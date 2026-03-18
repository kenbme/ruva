class Transpiler < Prism::Visitor
  def initialize
    @output = ""
    @indent = 0
    @vars = Set.new
  end

  def emit(line)
    @output << ("  " * @indent) + line + "\n"
  end

  def result
    @output
  end

  def visit_def_node(node)
    name = node.name == :main ? "ruva_main" : node.name
    emit "public static RuvaObject #{name}() {"
    @indent += 1
    node.body&.accept(self)
    @indent -= 1
    emit "}"
  end

  def visit_local_variable_write_node(node)
    name = node.name
    value = node.value
    if @vars.include?(name)
      emit "#{name} = #{expression(value)};"
    else
      @vars << name
      emit "var #{name} = #{expression(value)};"
    end
  end

  def visit_return_node(node)
    if node.arguments && node.arguments.arguments.any?
      value = node.arguments.arguments.first
      emit "return #{expression(value)};"
    else
      emit "return;"
    end
  end

  def visit_if_node(node)
    emit_if_chain(node)
  end

  def emit_if_chain(node, first: true)
    condition = expression(node.predicate)

    if first
      emit "if (#{condition}) {"
    else
      emit "else if (#{condition}) {"
    end

    @indent += 1
    node.statements&.accept(self)
    @indent -= 1

    emit "}"

    if node.consequent
      if node.consequent.is_a?(Prism::IfNode)
        # else if
        emit_if_chain(node.consequent, first: false)
      else
        # else
        emit "else {"
        @indent += 1
        node.consequent.accept(self)
        @indent -= 1
        emit "}"
      end
    end
  end

  def visit_while_node(node)
    condition = expression(node.predicate)

    emit "while (Ruva.truthy(#{condition})) {"
    @indent += 1

    node.statements&.accept(self)

    @indent -= 1
    emit "}"
  end

  def visit_break_node(node)
    emit "break;"
  end

  RUVA_OPS = %i[puts gets]

  def visit_call_node(node)
    name = node.name
    args = node.arguments&.arguments || []

    args_str = args.map { |arg| expression(arg) }.join(", ")

    if RUVA_OPS.include?(name)
      emit "Ruva.puts(#{args_str});"
    else
      emit "#{name}(#{args_str});"
    end
  end

  MATH_OPS = %i[+ - * / % **]
  MATH_OPS_NAME = %w[add sub mul div mod pow]

  def expression(node)
    case node
    when Prism::IntegerNode
      node.value
    when Prism::CallNode
      if (op_idx = MATH_OPS.index(node.name))
        left = expression(node.receiver)
        right = expression(node.arguments.arguments.first)
        op_name = MATH_OPS_NAME[op_idx]
        "Ruva.#{op_name}(#{left}, #{right})"
      else
        name = node.name
        args = node.arguments&.arguments || []
        args_str = args.map { |arg| expression(arg) }.join(", ")
        "#{name}(#{args_str})"
      end
    when Prism::LocalVariableReadNode
      node.name
    when Prism::TrueNode
      true
    else
      p node
      "/* unsupported */"
    end
  end
end
