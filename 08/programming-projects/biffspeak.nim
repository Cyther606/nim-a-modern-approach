import rdstdin, strutils

let
  message = readLineFromStdin "Enter message: "
  biffpad: array[6, tuple[letter: string,
                          biff: string]] = [("A", "4"),
                                            ("B", "8"),
                                            ("E", "3"),
                                            ("I", "1"),
                                            ("O", "0"),
                                            ("S", "5")]

proc biffSpeak(s: string = message): string =
  result = ""
  for i in 0 .. <s.len:
    var noMatch = true
    for key in 0 .. <biffpad.len:
      case key
      of 0:
        if biffpad[key].letter.contains s[i].toUpper:
          result = result & biffpad[key].biff
          noMatch = false
      of 1:
        if biffpad[key].letter.contains s[i].toUpper:
          result = result & biffpad[key].biff
          noMatch = false
      of 2:
        if biffpad[key].letter.contains s[i].toUpper:
          result = result & biffpad[key].biff
          noMatch = false
      of 3:
        if biffpad[key].letter.contains s[i].toUpper:
          result = result & biffpad[key].biff
          noMatch = false
      of 4:
        if biffpad[key].letter.contains s[i].toUpper:
          result = result & biffpad[key].biff
          noMatch = false
      of 5:
        if biffpad[key].letter.contains s[i].toUpper:
          result = result & biffpad[key].biff
          noMatch = false
      else: discard
    if noMatch: result = result & s[i].toUpper

echo biffSpeak(), "!!!!11!!!11!!!"
