import rdstdin, strutils

let value = parseFloat readLineFromStdin "Enter ε (small floating point number): "

proc factorial(n: float): float =
  if n == 0: 1.0
  elif n == 1: 1.0
  else: n * factorial(n - 1)

proc approximateE(val = value): float =
  var
    acc = 1.0
    temp: float
    i = 1.0
  while abs(acc - temp) >= val:
    temp = acc
    acc += (1 / factorial(i))
    i += 1.0
  acc

echo "Approximation of E: ", approximateE()
