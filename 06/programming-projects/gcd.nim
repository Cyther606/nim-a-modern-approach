import rdstdin, strutils

let values = readLineFromStdin("Enter two integers: ").split.map(parseInt)

proc gcd(m = values[0], n = values[1]): int =
  var
    m = m
    n = n
    rem: int

  if n == 0: m
  else:
    rem = m mod n
    m = n
    n = rem
    gcd(m, n)

echo "Greatest common divisor: ", gcd()
