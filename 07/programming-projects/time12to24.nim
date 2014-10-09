import rdstdin, strutils

let time12 = readLineFromStdin "Enter a time (hours:minutes [AM|PM]): "

proc getTime24(time12: string = time12): tuple[hours24: int, minutes24: int] =
  var hours24: int
  let
    time12_split = time12.split(':')
    time12_resplit = time12_split[1].split
    hours12 = parseInt time12_split[0]
    minutes12 = parseInt time12_resplit[0]
    am = if time12_resplit[1].toUpper.contains 'A': true else: false

  if am:
    case hours12
    of 1..11: hours24 = hours12
    of 12: hours24 = hours12 - 12
    else: discard
  else:
    case hours12
    of 1..11: hours24 = hours12 + 12
    of 12: hours24 = hours12
    else: discard

  (hours24, minutes12)

let t24 = getTime24()
echo "Equivalent 24-hour time: ", t24.hours24.intToStr(2), ":", t24.minutes24
