import rdstdin, strutils

let fraction = readLineFromStdin("Enter a fraction: ").split('/').map(parseInt)

proc gcd(m = fraction[0], n = fraction[1]): int =
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

echo "In lowest terms: ",
  (fraction[0] / gcd()).toInt, "/",
  (fraction[1] / gcd()).toInt
