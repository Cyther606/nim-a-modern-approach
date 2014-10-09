import rdstdin, strutils

let
  sentence = readLineFromStdin("Enter a sentence: ").split
  punct = ".?!"

var
  punctFound = ""
  word = ""

stdout.write "Reversal of sentence: "
for i in countdown(sentence.high, 0):
  word.add sentence[i]
  for j in 0 .. <word.len:
    if punct.contains(word[j]):
      punctFound.add word[j]
      word.delete(j, j)
  stdout.write word
  word = ""
  if i > 0: stdout.write " "
  else: stdout.write punctFound, "\n"
