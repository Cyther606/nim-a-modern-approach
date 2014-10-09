import rdstdin, strutils

let number = parseInt readLineFromStdin "Enter a number: "

proc isPrime(n = number): bool =
  var acc: int
  for i in 1 .. n:
    if n mod i == 0:
      if acc + 1 > 2: return false
      acc += 1
  return true

echo if isPrime(): "Prime" else: "Not prime"
