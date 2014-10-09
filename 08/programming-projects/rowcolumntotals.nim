import math, rdstdin, strfmt, strutils

var fiveByFive: array[5, seq[int]]
for i in 0 .. <fiveByFive.len:
  fiveByFive[i].newSeq(1)
  fiveByFive[i] = readLineFromStdin(interp"Enter row ${i+1}: ").split.map(parseInt)

stdout.write "Row totals: "
for i in 0 .. <fiveByFive.len:
  stdout.write fiveByFive[i].sum
  if i < fiveByFive.len - 1: stdout.write " "
  else: stdout.write "\n"

stdout.write "Column totals: "
var acc: array[5, int]
for k,v in fiveByFive:
  for i in 0 .. <v.len:
    acc[i] += v[i]
for i in 0 .. <acc.len:
  stdout.write acc[i]
  if i < acc.len - 1: stdout.write " "
  else: stdout.write "\n"
