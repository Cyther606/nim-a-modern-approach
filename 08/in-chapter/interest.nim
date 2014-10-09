import rdstdin, strfmt, strutils

const V = 100.00

let
  interest = parseInt readLineFromStdin "Enter interest rate: "
  years = parseInt readLineFromStdin "Enter number of years: "

var values = newSeq[seq[float]](5)

for i in 0 .. <values.len:
  values[i].newSeq(1)
  values[i][0] = V * (1 + ((interest + i) / 100))

for y in 1 .. <years:
  for i in 0 .. <values.len:
    values[i] = values[i] & values[i][y - 1] * (1 + ((interest + i) / 100))

echo "Years\t",
  format($interest & "%", "^7"),
  format($(interest + 1) & "%", "^8"),
  format($(interest + 2) & "%", "^8"),
  format($(interest + 3) & "%", "^8"),
  format($(interest + 4) & "%", "^8")

var wroteYr: bool
for y in 0 .. <years:
  for i in 0 .. <values.len:
    if not wroteYr:
      stdout.write format($(y + 1 + i), "^6"), "\t"
      wroteYr = true
    stdout.write values[i][y].formatFloat(ffDecimal, 2)
    if i == values.high:
      stdout.write "\n"
      wroteYr = false
    else: stdout.write "  "
