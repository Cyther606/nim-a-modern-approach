import rdstdin, strutils

let
  shares = parseFloat readLineFromStdin "Enter number of shares: "
  price = parseFloat readLineFromStdin "Enter price per share: "
  value = shares * price

proc calcCommission(val: float = value): float =
  if value < 2500: result = 0.017 * value + 30
  elif value <= 6250: result = 0.0066 * value + 56
  elif value <= 20000: result = 0.0034 * value + 76
  elif value <= 50000: result = 0.0022 * value + 100
  elif value <= 500000: result = 0.0011 * value + 155
  else: result = 0.0009 * value + 255
  if result < 39: return 39

proc calcRival(shares: float = shares): float =
  if shares < 2000: result = 0.03 * shares + 33
  else: result = 0.02 * shares + 33

echo "Your commission: $", calcCommission().formatFloat(ffDecimal, 2)
echo "Rival's commission: $", calcRival().formatFloat(ffDecimal, 2)
