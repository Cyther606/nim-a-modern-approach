import rdstdin, strfmt, strutils
let
  quantity = parseInt readLineFromStdin "How many numbers do you want to reverse? "
  numbers = readLineFromStdin(interp"Enter $quantity numbers: ").split.map(parseInt)
stdout.write "In reverse order: "
for i in countdown(quantity - 1, 0):
  stdout.write numbers[i]
  if i > 0: stdout.write " "
  else: stdout.write "\n"
