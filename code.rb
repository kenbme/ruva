def abacate
  return 2
end

def main
  a = 2 + 2
  a = 2 - 2
  a = 2 * 2
  a = 2 / 2
  a = 2 % 2
  a = 2 ** 2
  puts(a)

  abacate
  abacate()

  if true
    puts(a, 2)
  elsif true
    puts(a)
  else
    puts(a)
  end

  while true
    b = abacate()
    break
  end
end
