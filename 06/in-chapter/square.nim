import rdstdin, strfmt, strutils

echo "This program prints a table of squares."
let value = parseInt readLineFromStdin "Enter number of entries in table: "
for i in 1 .. value: echo i.format(">10"), (i * i).format(">10")
