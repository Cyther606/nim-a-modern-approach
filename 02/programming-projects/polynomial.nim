import rdstdin
from strutils import parseFloat, formatFloat, ffDecimal

let x = parseFloat readLineFromStdin "Enter a value for x: "

echo "3x^5 + 2x^4 - 5x^3 - x^2 + 7x - 6 = " &
  formatFloat((3 * (x * x * x * x * x)) +
    (2 * (x * x * x * x)) -
    (5 * (x * x * x)) -
    (x * x) +
    (7 * x) - 6, ffDecimal, 3)
