import rdstdin, strutils

let value = parseInt readLineFromStdin "Enter a positive integer: "

proc factorial(n: int): int =
  if n == 0: 1
  elif n == 1: 1
  else: n * factorial(n - 1)

proc approximateE(n: int = value): float =
  result = 1.0
  for i in 1 .. n:
    result += (1 / factorial(i))

echo "Approximation of E: ", approximateE()
