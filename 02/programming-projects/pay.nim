from math import trunc
import rdstdin
from strutils import parseInt

let amount = parseInt readLineFromStdin "Enter a dollar amount: "

proc divyamt(amt: int): tuple[twenties, tens, fives, ones: int] =
  var amt = amt

  let twenties = toInt(trunc(amt / 20))
  amt -= 20 * twenties

  let tens = toInt(trunc(amt / 10))
  amt -= 10 * tens

  let fives = toInt(trunc(amt / 5))
  amt -= 5 * fives

  let ones = toInt(trunc(amt / 1))
  amt -= 1 * ones

  (twenties, tens, fives, ones)

let divy = divyamt(amount)
echo "$20 bills: ", divy.twenties
echo "$10 bills: ", divy.tens
echo " $5 bills: ", divy.fives
echo " $1 bills: ", divy.ones
