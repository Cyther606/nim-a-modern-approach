import rdstdin, strutils
let dollarAmount = parseFloat readLineFromStdin "Enter an amount: "
echo "With tax added: $" & formatFloat(dollarAmount * 1.05, ffDecimal, 2)
