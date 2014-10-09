import rdstdin, strutils

let
  number = parseInt readLineFromStdin "Enter a two-digit number: "
  firstDigit = number mod 10
  secondDigit = (((number mod 100) - (number mod 10)) / 10).toInt

proc sayWord(n: int = number): string =
  case n
  of 10: return "ten"
  of 11: return "eleven"
  of 12: return "twelve"
  of 13: return "thirteen"
  of 14: return "fourteen"
  of 15: return "fifteen"
  of 16: return "sixteen"
  of 17: return "seventeen"
  of 18: return "eighteen"
  of 19: return "nineteen"
  else: discard

proc sayDigit(n: int = number): tuple[first, second: string] =
  var firstDigitSay, secondDigitSay:  string
  case firstDigit
  of 0: firstDigitSay = ""
  of 1: firstDigitSay = "one"
  of 2: firstDigitSay = "two"
  of 3: firstDigitSay = "three"
  of 4: firstDigitSay = "four"
  of 5: firstDigitSay = "five"
  of 6: firstDigitSay = "six"
  of 7: firstDigitSay = "seven"
  of 8: firstDigitSay = "eight"
  of 9: firstDigitSay = "nine"
  else: discard
  case secondDigit
  of 2: secondDigitSay = "twenty"
  of 3: secondDigitSay = "thirty"
  of 4: secondDigitSay = "forty"
  of 5: secondDigitSay = "fifty"
  of 6: secondDigitSay = "sixty"
  of 7: secondDigitSay = "seventy"
  of 8: secondDigitSay = "eighty"
  of 9: secondDigitSay = "ninety"
  else: discard

  (firstDigitSay, secondDigitSay)

stdout.write "You entered the number "
if number >= 10 and number <= 19: echo sayWord()
else: echo sayDigit().second, if firstDigit == 0: "" else: "-", sayDigit().first
