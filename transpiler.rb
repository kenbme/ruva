require "./emitter"

class Transpiler < Prism::Visitor
  def initialize
    @vars = Set.new
    @emitter = Emitter.new
  end

  def result
    @emitter.output
  end

  def visit_def_node(node)
    name = node.name == :main ? "ruva_main" : node.name.to_s
    @emitter.start_def(name)
    node.body&.accept(self)
    @emitter.end_def
  end

  def visit_local_variable_write_node(node)
    name = node.name
    value = node.value
    if @vars.include?(name)
      @emitter.var(name, expression(value))
    else
      @vars << name
      @emitter.init_var(name, expression(value))
    end
  end

  def visit_return_node(node)
    if node.arguments && node.arguments.arguments.any?
      value = node.arguments.arguments.first
      @emitter.return(expression(value))
    else
      @emitter.return
    end
  end

  def visit_if_node(node)
    emit_if_chain(node)
  end

  def emit_if_chain(node, first: true)
    condition = expression(node.predicate)

    if first
      @emitter.start_if(condition)
    else
      @emitter.start_elsif(condition)
    end

    node.statements&.accept(self)

    @emitter.end_if

    if node.consequent
      if node.consequent.is_a?(Prism::IfNode)
        # else if
        emit_if_chain(node.consequent, first: false)
      else
        # else
        @emitter.start_else
        node.consequent.accept(self)
        @emitter.end_else
      end
    end
  end

  def visit_while_node(node)
    condition = expression(node.predicate)

    @emitter.start_while(condition)
    node.statements&.accept(self)
    @emitter.end_while
  end

  def visit_break_node(node)
    @emitter.break
  end

  RUVA_OPS = %i[puts gets]

  def visit_call_node(node)
    expr = expression_call(node)

    # Decide tipo de chamada
    if MATH_OPS.include?(node.name)
      @emitter.math_call(MATH_OPS.index(node.name), *node.receiver ? [expression(node.receiver), expression(node.arguments.arguments.first)] : [])
    elsif RUVA_OPS.include?(node.name)
      @emitter.ruva_call(node.name)
    else
      @emitter.local_call(node.name)
    end

    # Emitir argumentos
    args = node.arguments&.arguments || []
    args.each_with_index do |a, i|
      @emitter.emit_expression(expression(a))
      @emitter.separator if i + 1 != args.size
    end

    @emitter.close_call
  end

  MATH_OPS = %i[+ - * / % **].freeze
  MATH_OPS_NAME = %w[add sub mul div mod pow].freeze

  def expression(node)
    case node
    when Prism::IntegerNode
      node.value
    when Prism::CallNode
      expression_call(node)
    when Prism::LocalVariableReadNode
      node.name
    when Prism::TrueNode
      true
    else
      p node
      "/* unsupported */"
    end
  end

  def expression_call(node)
    name = node.name
    args = node.arguments&.arguments || []

    if (op_idx = MATH_OPS.index(name))
      left = expression(node.receiver)
      right = expression(args.first)
      "Ruva.#{MATH_OPS_NAME[op_idx]}(#{left}, #{right})"
    else
      args_str = args.map { |arg| expression(arg) }.join(", ")
      "#{name}(#{args_str})"
    end
  end
end
