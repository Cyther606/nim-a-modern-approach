import rdstdin, strutils
let numbers = readLineFromStdin("Enter three numbers: ").split.map(parseFloat)
proc average(n1: float, n2: float): float = (n1 + n2) / 2
echo "Average of ", numbers[0], " and ", numbers[1], ": ", average(numbers[0], numbers[1]).formatFloat(ffDecimal, 2)
echo "Average of ", numbers[1], " and ", numbers[2], ": ", average(numbers[1], numbers[2]).formatFloat(ffDecimal, 2)
echo "Average of ", numbers[0], " and ", numbers[2], ": ", average(numbers[0], numbers[2]).formatFloat(ffDecimal, 2)
