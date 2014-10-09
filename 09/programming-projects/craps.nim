import math, rdstdin, strutils

randomize()

proc rollDice(): int =
  let sides: array[6, int] = [1, 2, 3, 4, 5, 6]
  result += sides[random(6)]
  result += sides[random(6)]

proc playGame(): bool =
  var
    rolls = 0
    thePoint: int

  while true:
    var roll = rollDice()
    echo "You rolled: ", roll

    if rolls == 0:
      if roll == 7 or roll == 11:
        return true
      elif roll == 2 or roll == 3 or roll == 12:
        return false
      else:
        thePoint = roll
        echo "Your point is ", thePoint
    else:
      if roll == thePoint:
        return true
      elif roll == 7:
        return false

    inc rolls

proc main() =
  var streak: tuple[wins: int, losses: int]
  while true:
    if playGame():
      echo "You win!"
      streak.wins += 1
    else:
      echo "You lose!"
      streak.losses += 1
    if readLineFromStdin("Play again (y/n)? ").contains({'y', 'Y'}):
      continue
    else:
      echo "Wins: ", streak.wins, "    ", "Losses: ", streak.losses
      break

main()
