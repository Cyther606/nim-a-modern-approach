import rdstdin, strutils

let
  time24 = readLineFromStdin("Enter a 24-hour time: ").split(':').map(parseInt)
  hours24 = time24[0]
  minutes24 = time24[1]

proc get12HrTime(hours: int = hours24): tuple[h: int, ap: string] =
  var
    h: int
    ap: string
  case hours
  of 0:
    h = hours + 12
    ap = "AM"
  of 1..11:
    h = hours
    ap = "AM"
  of 12:
    h = hours
    ap = "PM"
  of 13..23:
    h = hours - 12
    ap = "PM"
  of 24:
    h = hours - 12
    ap = "AM"
  else: discard
  (h, ap)

let time12 = get12HrTime(time24[0])
echo "Equivalent 12-hour time: ", time12.h, ":",
  minutes24.intToStr(2), " ", time12.ap
