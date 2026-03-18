require "./emitter"

class Transpiler < Prism::Visitor
  MATH_OPS = %i[+ - * / % **].freeze
  MATH_OPS_NAME = %w[add sub mul div mod pow].freeze
  RUVA_OPS = %i[puts gets].freeze

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

  def visit_string_node(node)
    @emitter.emit("#{expression(node)};")
  end

  def visit_call_node(node)
    @emitter.emit("#{expression(node)};")
  end

  def build_call_expression(node)
    name = node.name
    args = node.arguments&.arguments || []

    if (op_idx = MATH_OPS.index(name))
      left = expression(node.receiver)
      right = expression(args.first)
      @emitter.ruva_math_str(MATH_OPS_NAME[op_idx], left, right)
    elsif RUVA_OPS.include?(name)
      @emitter.ruva_call_str(name, build_args_str(args))
    else
      @emitter.local_call_str(name, build_args_str(args))
    end
  end

  def build_args_str(args)
    args.map { |arg| expression(arg) }.join(@emitter.separator_str)
  end

  def expression(node)
    case node
    when Prism::IntegerNode
      "Ruva.int(#{node.value})"

    when Prism::StringNode
      "Ruva.str(\"#{node.content}\")"

    when Prism::LocalVariableReadNode
      node.name

    when Prism::TrueNode
      "Ruva.true()"

    when Prism::FalseNode
      "Ruva.false()"

    when Prism::NilNode
      "Ruva.nil()"

    when Prism::CallNode
      build_call_expression(node)

    else
      p node
      "/* unsupported */"
    end
  end
end
