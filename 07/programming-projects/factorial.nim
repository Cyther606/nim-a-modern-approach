import rdstdin, strutils

let value = parseInt readLineFromStdin "Enter a positive integer: "

proc factorial(n = value): int =
  if n == 0: 1
  elif n == 1: 1
  else: n * factorial(n - 1)

echo "Factorial of ", value, ": ", factorial()
