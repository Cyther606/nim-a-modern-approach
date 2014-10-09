import rdstdin, strutils

let value = parseInt readLineFromStdin "Enter a number: "

proc calcDigits(val: int = value): int =
  if value < 10: result = 1
  elif value < 100: result = 2
  elif value < 1000: result = 3
  elif value <= 10000: result = 4

echo "The number ", value, " has ", calcDigits(), " digits"
