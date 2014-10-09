import rdstdin, strutils

let
  word = readLineFromStdin "Enter a word: "
  values: array[7, tuple[val: int, letters: string]] = [(1, "AEILNORSTU"),
                                                        (2, "DG"),
                                                        (3, "BCMP"),
                                                        (4, "FHVWY"),
                                                        (5, "K"),
                                                        (8, "JX"),
                                                        (10, "QZ")]

proc calcWordVal(w = word): int =
  for i in 0 .. <w.len:
    for k,v in values:
      if v.letters.contains w[i].toUpper:
        result += v.val
        break

echo "Scrabble value: ", calcWordVal()
