require "prism"
require "./transpiler"

code = File.read("code.rb")
transpiler = Transpiler.new

ast = Prism.parse(code).value
ast.accept(transpiler)

puts transpiler.result
