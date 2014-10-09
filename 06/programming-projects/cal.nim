import rdstdin, strfmt, strutils

let
  days = parseInt readLineFromStdin "Enter number of days in month: "
  startingOn = parseInt readLineFromStdin "Enter starting day of week (1=Sun, 7=Sat): "

proc endOfWeek(start = startingOn): seq[int] =
  result = newSeq[int]()
  case start
  of 1: result = result & @[7, 14, 21, 28]
  of 2: result = result & @[6, 13, 20, 27]
  of 3: result = result & @[5, 12, 19, 26]
  of 4: result = result & @[4, 11, 18, 25]
  of 5: result = result & @[3, 10, 17, 24]
  of 6: result = result & @[2, 9, 16, 23, 30]
  of 7: result = result & @[1, 8, 15, 22, 29]
  else: discard

var
  cal: array[1..42, bool]
  n = 1

for i in startingOn .. days - 1 + startingOn:
  cal[i] = true

for i in 1 .. cal.len:
  if cal[i]:
    stdout.write n.format ">2"
    if contains(endOfWeek(), n): stdout.write "\n"
    elif n == days: stdout.write "\n"
    else: stdout.write "  "
    inc n
  else:
    if i < days: stdout.write "    "
