import rdstdin, strutils

let
  phoneAlpha = readLineFromStdin "Enter phone number: "
  keypad: array[2..9, string] = ["ABC",
                                 "DEF",
                                 "GHI",
                                 "JKL",
                                 "MNO",
                                 "PRS",
                                 "TUV",
                                 "WXY"]

proc phoneNumeric(s: string = phoneAlpha): string =
  result = ""
  for i in 0 .. <s.len:
    var noMatch = true
    for key in 2 .. 9:
      case key
      of 2:
        if keypad[key].contains s[i]:
          result = result & $key
          noMatch = false
      of 3:
        if keypad[key].contains s[i]:
          result = result & $key
          noMatch = false
      of 4:
        if keypad[key].contains s[i]:
          result = result & $key
          noMatch = false
      of 5:
        if keypad[key].contains s[i]:
          result = result & $key
          noMatch = false
      of 6:
        if keypad[key].contains s[i]:
          result = result & $key
          noMatch = false
      of 7:
        if keypad[key].contains s[i]:
          result = result & $key
          noMatch = false
      of 8:
        if keypad[key].contains s[i]:
          result = result & $key
          noMatch = false
      of 9:
        if keypad[key].contains s[i]:
          result = result & $key
          noMatch = false
      else: discard
    if noMatch: result = result & s[i]

echo "In numberic form: ", phoneNumeric()
