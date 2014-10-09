import math, rdstdin, strfmt, strutils

echo "This program prints a table of squares."
let value = parseInt readLineFromStdin "Enter number of entries in table: "
for i in 1 .. value:
  echo i.format(">10"), (i * i).format(">10")
  if i mod 24 == 0:
    while true:
      let c = readLineFromStdin "Press Enter to continue..."
      if c == "": break
