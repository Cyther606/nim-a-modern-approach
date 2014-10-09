import math, rdstdin, strutils

let number = parseInt readLineFromStdin "Enter a number: "

proc repDigit(n = number): bool =
  var
    n = n
    digit: int
    digitSeen: array[10, bool]

  while n > 0:
    digit = n mod 10
    if digitSeen[digit]: return true
    digitSeen[digit] = true
    n = (n / 10).trunc.toInt

  return false

echo if repDigit(): "Repeated digit" else: "No repeated digit"
