import math, rdstdin, sequtils, strutils

let words = readLineFromStdin("Enter a sentence: ").split.mapIt(int, it.len)

proc average(words = words): float =
  words.sum / words.len

echo "Average word length: ", average().formatFloat(ffDecimal, 1)
