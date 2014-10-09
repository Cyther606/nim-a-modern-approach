from math import pi
import rdstdin
from strutils import parseFloat, formatFloat, ffDecimal

let
  r = parseFloat readLineFromStdin "Enter radius of sphere: "
  v = (4 / 3) * pi * (r * r * r)

echo "Volume of sphere: " & formatFloat(v, ffDecimal, 1)
