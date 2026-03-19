class Emitter
  attr_reader :output

  def initialize
    @output = ""
    @indent = 0
  end

  def emit(line)
    @output <<("  " * @indent) + line + "\n"
  end

  def start_block
    emit("{")
    @indent += 1
  end

  def end_block
    @indent -= 1
    emit("}")
  end

  def start_def(name)
    emit "public RuvaObject #{name}()"
    start_block
  end

  def start_self_def(name)
    emit "public static RuvaObject #{name}()"
    start_block
  end

  def end_def
    end_block
  end

  def start_if(condition)
    emit "if (Ruva.ruva_truthy(#{condition}))"
    start_block
  end

  def end_if
    end_block
  end

  def start_elsif(condition)
    emit "else if (Ruva.ruva_truthy(#{condition}))"
    start_block
  end

  def start_else
    emit "else"
    start_block
  end

  def end_else
    end_block
  end

  def break
    emit "break;"
  end

  def return(value = nil)
    emit "return #{value};"
  end

  def init_var(name, value)
    emit "var #{name} = #{value};"
  end

  def var(name, value)
    emit "#{name} = #{value};"
  end

  def start_while(condition)
    emit "while (Ruva.ruva_truthy(#{condition}))"
    start_block
  end

  def end_while
    end_block
  end

  def ruva_call(name, args_str)
    class_call("Ruva", name, args_str)
  end

  def ruva_call_str(name, args_str)
    "Ruva.ruva_#{name}(#{args_str})"
  end

  def ruva_math(op, left, right)
    emit "Ruva.ruva_#{op}(#{left}#{separator_str}#{right});"
  end

  def class_call(clazz, name, args_str)
    emit "#{clazz}.#{name}(#{args_str});"
  end

  def local_call(name, args_str)
    emit "#{name}(#{args_str});"
  end

  def ruva_math_str(op, left, right)
    "Ruva.ruva_#{op}(#{left}#{separator_str}#{right})"
  end

  def local_call_str(op, args_str)
    "#{op}(#{args_str})"
  end

  def start_class(name)
    emit "public class #{name}"
    start_block
  end

  def end_class
    end_block
  end

  def separator_str
    ","
  end
end
