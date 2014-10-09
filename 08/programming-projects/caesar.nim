import rdstdin, strutils

let
  message = readLineFromStdin "Enter message to be encrypted: "
  shiftAmount = parseInt readLineFromStdin "Enter shift amount (1-25): "

proc caesar(message = message, n = shiftAmount): string =
  result = ""
  for i in 0 .. <message.len:
    case message[i].ord
    of 65..90: result.add chr((((message[i].ord - ord('A')) + n) mod 26) + ord('A'))
    of 97..122: result.add chr((((message[i].ord - ord('a')) + n) mod 26) + ord('a'))
    else: result.add message[i]

echo "Encrypted message: ", caesar()
