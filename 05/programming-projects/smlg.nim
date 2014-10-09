import rdstdin, strutils
let fourInts = readLineFromStdin("Enter four integers separated by spaces: ").split.map(parseInt)
echo "Largest: ", fourInts.max
echo "Smallest: ", fourInts.min
