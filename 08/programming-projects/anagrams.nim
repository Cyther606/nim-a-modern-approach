import rdstdin, strutils

let
  word1 = readLineFromStdin "Enter first word: "
  word2 = readLineFromStdin "Enter second word: "
  letters: array[26, string] = ["A", "B", "C", "D", "E", "F", "G", "H",
                                "I", "J", "K", "L", "M", "N", "O", "P",
                                "Q", "R", "S", "T", "U", "V", "W", "X",
                                "Y", "Z"]

proc isAnagram(w1 = word1, w2 = word2): bool =
  var chars: array[26, int] = [0, 0, 0, 0, 0, 0, 0, 0,
                               0, 0, 0, 0, 0, 0, 0, 0,
                               0, 0, 0, 0, 0, 0, 0, 0,
                               0, 0]

  for i in 0 .. <w1.len:
    if w1[i].toUpper.ord >= 65 and w1[i].toUpper.ord <= 90:
      chars[w1[i].toUpper.ord - ord('A')] += 1

  for i in 0 .. <w2.len:
    if w2[i].toUpper.ord >= 65 and w2[i].toUpper.ord <= 90:
      chars[w2[i].toUpper.ord - ord('A')] -= 1

  for i in 0 .. <chars.len:
    if chars[i] != 0: return false

  return true

echo "The words are ", if isAnagram(): "anagrams." else: "not anagrams."
