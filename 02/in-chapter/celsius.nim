import rdstdin
from strutils import parseFloat, formatFloat, ffDecimal

const
  FREEZING_PT = 32.0
  SCALE_FACTOR = 5 / 9

let
  fahrenheit = parseFloat readLineFromStdin "Enter Fahrenheit temperature: "
  celsius = (fahrenheit - FREEZING_PT) * SCALE_FACTOR

echo "Celsius equivalent: " & formatFloat(celsius, ffDecimal, 1)
