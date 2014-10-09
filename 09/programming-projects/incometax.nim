import rdstdin, strutils

let income = parseFloat readLineFromStdin "Enter the amount of taxable income: "

proc calcTax(income: float = income): float =
  if income <= 750: income * 0.01
  elif income > 750 and income <= 2250: 0.02 * (income - 750) + 7.5
  elif income > 2250 and income <= 3750: 0.03 * (income - 2250) + 37.5
  elif income > 3750 and income <= 5250: 0.04 * (income - 3750) + 82.5
  elif income > 5250 and income <= 7000: 0.05 * (income - 5250) + 142.5
  else: 0.06 * (income - 7000) + 230

echo "Tax due: $", calcTax().formatFloat(ffDecimal, 2)
