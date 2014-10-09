import rdstdin, strutils

let
  fractions = readLineFromStdin "Enter two fractions separated by a plus, minus, divide or multiply sign: "
  operations: array[4, string] = ["+", "-", "*", "/"]
  fractions_split = fractions.split({'+', '-', '*', '/'}).map(parseInt)
  num1 = fractions_split[0]
  denom1 = fractions_split[1]
  num2 = fractions_split[2]
  denom2 = fractions_split[3]

proc findOperation(s: string = fractions): int =
  if s.contains '+': 0
  elif s.contains '-': 1
  elif s.contains '*': 2
  else: 3

proc doOperation(operation = findOperation()): tuple[numerator: int, denominator: int] =
  var numerator, denominator: int
  case operation
  of 0:
    numerator = num1 * denom2 + num2 * denom1
    denominator = denom1 * denom2
  of 1:
    numerator = num1 * denom2 - num2 * denom1
    denominator = denom1 * denom2
  of 2:
    numerator = num1 * num1
    denominator = denom1 * denom2
  of 3:
    numerator = num1 * denom2
    denominator = denom1 * num1
  else: discard

  (numerator, denominator)

let frac = doOperation()
echo "The result is ", frac.numerator, "/", frac.denominator
