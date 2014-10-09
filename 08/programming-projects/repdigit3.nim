import math, rdstdin, strutils

proc repDigit(n: int): bool =
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

while true:
  let number = parseInt readLineFromStdin "Enter a number: "
  if number <= 0: break
  echo if repDigit(number): "Repeated digit" else: "No repeated digit"
