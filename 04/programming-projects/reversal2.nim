import rdstdin, strutils

let number = parseInt readLineFromStdin "Enter a two or three-digit number: "

proc reversal(n: int = number): seq[int] =
  result = newSeq[int](3)
  result[0] = n mod 10
  result[1] = (((n mod 100) - (n mod 10)) / 10).toInt
  if n > 99: result[2] = (((n mod 1000) - (n mod 100)) / 100).toInt

let rnumber = reversal()

echo "The reversal is: ", if number < 100: $rnumber[0] & $rnumber[1]
                          else: $rnumber[0] & $rnumber[1] & $rnumber[2]
