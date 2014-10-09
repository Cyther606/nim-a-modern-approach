import rdstdin, strutils

let
  sentence = readLineFromStdin "Enter a sentence: "
  vowels = "AEIOU"

proc countVowels(s = sentence): int =
  for i in 0 .. <s.len:
    if vowels.contains s[i].toUpper: result += 1

echo "Your sentence contains ", countVowels(), " vowels."
