import rdstdin, strutils

echo "This program prints a table of squares."
let value = parseInt readLineFromStdin "Enter max value of squares in table: "
proc isEven(n: int): bool = n mod 2 == 0
for i in 1 .. value:
  if (i * i) <= value and isEven(i * i): echo i * i
