import rdstdin
from strutils import parseFloat, formatFloat, ffDecimal

let
  loan = parseFloat readLineFromStdin "Enter amount of loan: "
  interest = parseFloat readLineFromStdin "Enter interest rate: "
  interestMo = (interest / 100) / 12
  payment = parseFloat readLineFromStdin "Enter monthly payment: "

proc trackbal(bal = loan, imo = interestMo, pay = payment, months = 3): seq[float] =
  result = newSeq[float](months)
  var bal = bal
  for i in 0 .. <months:
    bal = (bal - pay) + (bal * imo)
    result[i] = bal

let balance = trackbal()

echo "Balance remaining after first payment: $" & formatFloat(balance[0], ffDecimal, 2)
echo "Balance remaining after second payment: $" & formatFloat(balance[1], ffDecimal, 2)
echo "Balance remaining after third payment: $" & formatFloat(balance[2], ffDecimal, 2)
