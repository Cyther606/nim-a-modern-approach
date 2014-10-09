import rdstdin, strutils

let number = parseInt readLineFromStdin "Enter a two-digit number: "

proc reversal(n: int = number): seq[int] =
  result = newSeq[int](2)
  result[0] = n mod 10
  result[1] = (((n mod 100) - result[0]) / 10).toInt

let rnumber = reversal()

echo "The reversal is: ", rnumber[0], rnumber[1]
