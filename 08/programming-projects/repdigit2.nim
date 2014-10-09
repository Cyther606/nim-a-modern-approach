import math, rdstdin, strutils

let number = parseInt readLineFromStdin "Enter a number: "

proc repDigit(n = number): array[10, int] =
  var
    n = n
    digit: int
    digitSeen: array[10, int]

  while n > 0:
    digit = n mod 10
    digitSeen[digit] += 1
    n = (n / 10).trunc.toInt

  result = digitSeen

let repDigits = repDigit()

stdout.write "Digit:\t\t"
for i in 0 .. 9:
  stdout.write i
  if i < 9: stdout.write "  "
  else: stdout.write "\n"

stdout.write "Occurrences:\t"
for i in 0 .. 9:
  stdout.write repDigits[i]
  if i < 9: stdout.write "  "
  else: stdout.write "\n"
