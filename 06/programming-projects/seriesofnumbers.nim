import rdstdin, strutils
var series = newSeq[float]()
block getseries:
  while true:
    series = series & parseFloat readLineFromStdin "Enter a number: "
    if series[series.high] <= 0: break getseries
echo "The largest number entered was ", series.max
