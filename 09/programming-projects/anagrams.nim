import rdstdin, strutils

let
  word1 = readLineFromStdin "Enter first word: "
  word2 = readLineFromStdin "Enter second word: "
  letters: array[26, string] = ["A", "B", "C", "D", "E", "F", "G", "H",
                                "I", "J", "K", "L", "M", "N", "O", "P",
                                "Q", "R", "S", "T", "U", "V", "W", "X",
                                "Y", "Z"]
  counts: array[26, int] = [0, 0, 0, 0, 0, 0, 0, 0,
                            0, 0, 0, 0, 0, 0, 0, 0,
                            0, 0, 0, 0, 0, 0, 0, 0,
                            0, 0]

proc readWord(w: string, c = counts): array[26, int] =
  result = c
  for i in 0 .. <w.len:
    if w[i].toUpper.ord >= 65 and w[i].toUpper.ord <= 90:
      result[w[i].toUpper.ord - ord('A')] += 1

proc equalArray(a1: array[26, int], a2: array[26, int]): bool =
  if a1 == a2: return true else: return false

echo "The words are ",
  if readWord(word1).equalArray(readWord(word2)): "anagrams."
  else: "not anagrams."
