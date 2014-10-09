import math, rdstdin, strutils

let number = parseFloat readLineFromStdin "Enter an integer with two or more digits: "

proc `^`(base: float; exp: int): float =
  var exp = exp
  result = 1.0
  while exp > 0:
    result *= base
    dec(exp)

proc calcDigits(n = number): int =
  var
    i = 0
    n = n
  if n == 0: 1
  else:
    while not (n < 1):
      n = n / 10
      inc i
    i

proc reversal(n = number, d = calcDigits()): seq[float] =
  result = newSeq[float]()
  for i in countup(0, d - 1):
    result = result & ((n mod (10.0 * 10^i)) - (n mod (1 * 10^i))) / (10^i)

let rnumber = reversal()

stdout.write "The reversal is: "
for i in countup(0, calcDigits() - 1): stdout.write rnumber[i]
echo ""
