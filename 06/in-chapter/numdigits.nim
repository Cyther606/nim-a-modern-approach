import rdstdin, strutils

let value = parseFloat readLineFromStdin "Enter a nonnegative integer: "

proc calcDigits(v = value): int =
  var
    i = 0
    v = v
  if v == 0: 1
  else:
    while not (v < 1):
      v = v / 10
      inc i
    i

echo "The number has ", calcDigits(), " digit(s)."
