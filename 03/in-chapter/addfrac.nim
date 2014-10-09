import rdstdin, strutils

let
  fraction1 = readLineFromStdin("Enter first fraction: ").split('/').map(parseInt)
  fraction2 = readLineFromStdin("Enter second fraction: ").split('/').map(parseInt)
  num1 = fraction1[0]
  denom1 = fraction1[1]
  num2 = fraction2[0]
  denom2 = fraction2[1]
  numerator = num1 * denom2 + num2 * denom1
  denominator = denom1 * denom2

echo "The sum is ", numerator, "/", denominator
