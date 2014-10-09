import math, rdstdin, strutils

echo """
Guess the secret number between 1 and 100.
"""

randomize()

proc main() =
  var guesses = 0
  let secret = random(100) + 1
  echo "A new number has been chosen."
  while true:
    let guess = parseInt readLineFromStdin "Enter guess: "
    inc guesses
    if guess < secret:
      echo "Too low; try again."
      continue
    elif guess > secret:
      echo "Too high; try again."
      continue
    elif guess == secret:
      echo "You won in ", guesses, " guesses!"
      break

main()
