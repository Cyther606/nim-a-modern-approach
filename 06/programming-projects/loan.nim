import rdstdin, strutils

let
  loan = parseFloat readLineFromStdin "Enter amount of loan: "
  interest = parseFloat readLineFromStdin "Enter interest rate: "
  interestMo = (interest / 100) / 12
  payment = parseFloat readLineFromStdin "Enter monthly payment ($): "
  numberPayments = parseInt readLineFromStdin "Enter number of monthly payments: "

proc trackbal(bal = loan,
              imo = interestMo,
              pay = payment,
              months = numberPayments): seq[float] =
  result = newSeq[float](months)
  var bal = bal
  for i in 0 .. <months:
    bal = (bal - pay) + (bal * imo)
    result[i] = bal

let balance = trackbal()

for i in 0 .. <balance.len:
  echo "Balance remaining after payment ",
    i + 1, ": $", formatFloat(balance[i], ffDecimal, 2)
