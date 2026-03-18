class Emitter
  attr_reader :output

  def initialize
    @output = ""
  end

  def emit(line)
    @output << line + "\n"
  end

  def start_def(name)
    emit "public static RuvaObject #{name}() {"
  end

  def end_def
    emit "}"
  end

  def start_if(condition)
    emit "if (#{condition}) {"
  end

  def end_if
    emit "}"
  end

  def start_elsif(condition)
    emit "else if (#{condition}) {"
  end

  def start_else
    emit "else {"
  end

  def end_else
    emit "}"
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
    emit "while (Ruva.truthy(#{condition})) {"
  end

  def end_while
    emit "}"
  end
end
