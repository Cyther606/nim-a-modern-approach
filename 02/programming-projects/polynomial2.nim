import rdstdin
from strutils import parseFloat, formatFloat, ffDecimal

let x = parseFloat readLineFromStdin "Enter a value for x: "

echo "((((3x +2)x-5)x-1)x+7)x-6 = " &
  formatFloat(((((3 * x + 2) * x - 5) * x - 1) * x + 7) * x - 6, ffDecimal, 3)
