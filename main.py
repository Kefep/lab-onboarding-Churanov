def calc_bonus(x, y, z):
  res = 0
  if x > 1000:
    for i in range(y):
      if z == 1:
        res += x * 0.15
      elif z == 2:
        res += x * 0.10
      else:
        res += x * 0.05
  else:
    if y > 10:
      res = x * y * 0.02
    else:
      res x * y * 0.01
  return res

# Ошибки: 
# неинформативные имена - x y z
# числа неизвестного происхождения
# z в цикле for i in range(y) не меняется -> повторяется одно и тоже сложение
# разная логика в двух ветках
