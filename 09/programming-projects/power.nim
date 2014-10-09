import math, rdstdin, strutils

let
  x = parseFloat readLineFromStdin "Enter int value for x: "
  n = parseFloat readLineFromStdin "Enter int value for n: "

proc power(x = x, n = n): float =
  if n == 0: return 1.0
  elif n mod 2 == 0:
    # use formula: x^n = ( x^(n/2) )^2
    result = power(x, n / 2) * power(x, n / 2)
  else:
    # use formula: x^n = x * x^(n - 1)
    result = x * (power(x, n - 1))

echo power()
