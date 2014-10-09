import math, rdstdin, strutils
echo "This program sums a series of numbers."
let values = readLineFromStdin("Enter numbers: ").split.map(parseFloat)
echo "The sum is: ", values.sum
