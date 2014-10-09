import math, rdstdin, sequtils, strfmt, strutils

var fiveByFive: array[5, seq[int]]
for i in 0 .. <fiveByFive.len:
  fiveByFive[i].newSeq(1)
  fiveByFive[i] = readLineFromStdin(interp"Enter 5 quiz grades for student ${i+1}: ").split.map(parseInt)

for i in 0 .. <fiveByFive.len:
  echo "Total score for student ", i + 1, ": ", fiveByFive[i].sum
  echo "Average score for student ", i + 1, ": ", (fiveByFive[i].sum / fiveByFive[i].len).formatFloat(ffDecimal, 1)

var quizes: array[5, array[5, int]]
for i in 0 .. <fiveByFive.len:
  for k,quiz in fiveByFive:
    quizes[i][k] = quiz[i]

for i in 0 .. <quizes.len:
  echo "Average score for quiz ", i + 1, ": ", (quizes[i].sum / quizes[i].len).formatFloat(ffDecimal, 1)
  echo "High score for quiz ", i + 1, ": ", quizes[i].max
  echo "Low score for quiz ", i + 1, ": ", quizes[i].min

for i in 0 .. <quizes.len:
  for j in 0 .. <quizes[i].len:
    stdout.write quizes[i][j], " "
  stdout.write "\n"
