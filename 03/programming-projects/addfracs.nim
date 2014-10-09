import rdstdin, strutils

let
  fractions = readLineFromStdin("Enter two fractions separated by a plus sign: ").split({'/', '+'}).map(parseInt)
  num1 = fractions[0]
  denom1 = fractions[1]
  num2 = fractions[2]
  denom2 = fractions[3]
  numerator = num1 * denom2 + num2 * denom1
  denominator = denom1 * denom2

echo "The sum is ", numerator, "/", denominator
