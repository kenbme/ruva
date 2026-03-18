class Emitter
  attr_reader :output

  def initialize(ruva_class)
    @output = ""
    @indent = 0
    @ruva_class = ruva_class
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
    emit "public static RuvaObject #{name}()"
    start_block
  end

  def end_def
    end_block
  end

  def start_if(condition)
    emit "if (#{condition})"
    start_block
  end

  def end_if
    end_block
  end

  def start_elsif(condition)
    emit "else if (#{condition})"
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
    emit "while (#{@ruva_class}.truthy(#{condition}))"
    start_block
  end

  def end_while
    end_block
  end

  def ruva_call(name, args_list)
    class_call(@ruva_class, name, args_list)
  end

  def class_call(clazz, name, args_list)
    emit "#{clazz}.#{name}(#{args_list.join(",")});"
  end

  def local_call(name, args_list)
    emit "#{name}(#{args_list.join(",")});"
  end
end
