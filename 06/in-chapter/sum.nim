import math, rdstdin, strutils
echo "This program sums a series of integers."
let values = readLineFromStdin("Enter integers: ").split.map(parseInt)
echo "The sum is: ", values.sum
