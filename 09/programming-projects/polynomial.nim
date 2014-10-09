import rdstdin, strutils

let x = parseFloat readLineFromStdin "Enter a value for x: "

proc fxp(x = x): float =
  (3 * (x * x * x * x * x)) +
    (2 * (x * x * x * x)) -
    (5 * (x * x * x)) -
    (x * x) +
    (7 * x) - 6

echo "3x^5 + 2x^4 - 5x^3 - x^2 + 7x - 6 = ", formatFloat(fxp(), ffDecimal, 3)
