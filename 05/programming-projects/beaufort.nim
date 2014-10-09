import rdstdin, strutils

let windSpeed = parseFloat readLineFromStdin "Enter a wind speed (knots): "

proc beaufort(speed: float = windSpeed): string =
  if speed < 1: "Calm"
  elif speed <= 3: "Light air"
  elif speed >= 4 and speed <= 27: "Breeze"
  elif speed >= 28 and speed <= 47: "Gale"
  elif speed >= 48 and speed <= 63: "Storm"
  else: "Hurricane"

echo "Description: ", beaufort()
