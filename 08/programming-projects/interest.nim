import rdstdin, strfmt, strutils

const V = 100.00

let
  interest = parseFloat readLineFromStdin "Enter interest rate (compounded monthly): "
  years = parseInt readLineFromStdin "Enter number of years: "

var values = newSeq[seq[float]](5)

proc compoundMonthly(n: float): float =
  let
    m1 = n * (1 + (interest / 100))
    m2 = m1 * (1 + (interest / 100))
    m3 = m2 * (1 + (interest / 100))
    m4 = m3 * (1 + (interest / 100))
    m5 = m4 * (1 + (interest / 100))
    m6 = m5 * (1 + (interest / 100))
    m7 = m6 * (1 + (interest / 100))
    m8 = m7 * (1 + (interest / 100))
    m9 = m8 * (1 + (interest / 100))
    m10 = m9 * (1 + (interest / 100))
    m11 = m10 * (1 + (interest / 100))
    m12 = m11 * (1 + (interest / 100))

  result = m12

for i in 0 .. <values.len:
  values[i].newSeq(1)
  values[i][0] = V * (1 + ((interest + i.toFloat) / 100))

for y in 1 .. <years:
  for i in 0 .. <values.len:
    values[i] = values[i] & compoundMonthly(values[i][y - 1] + i.toFloat)

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
