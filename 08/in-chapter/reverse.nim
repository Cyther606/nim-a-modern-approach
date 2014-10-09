import rdstdin, strfmt, strutils
const N = 10
let numbers = readLineFromStdin(interp"Enter $N numbers: ").split.map(parseInt)
stdout.write "In reverse order: "
for i in countdown(N - 1, 0):
  case i
  of 0: echo numbers[i]
  of 1..N - 1: stdout.write numbers[i], " "
  else: discard
