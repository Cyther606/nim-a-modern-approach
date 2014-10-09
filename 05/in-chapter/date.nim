import rdstdin, strutils

let
  date = readLineFromStdin("Enter a date (mm/dd/yy): ").split('/').map(parseInt)
  month = date[0]
  day = date[1]
  year = date[2]

proc getMonth(month: int = month): string =
  case month
  of 1: result = "January"
  of 2: result = "February"
  of 3: result = "March"
  of 4: result = "April"
  of 5: result = "May"
  of 6: result = "June"
  of 7: result = "July"
  of 8: result = "August"
  of 9: result = "September"
  of 10: result = "October"
  of 11: result = "November"
  of 12: result = "December"
  else: discard

proc getDay(day: int = day): string =
  case day mod 10
  of 0: result = "th"
  of 1: result = "st"
  of 2:
    if day == 12: result = "th"
    else: result = "nd"
  of 3:
    if day == 13: result = "th"
    else: result = "rd"
  else: discard

echo "Dated this ", day, getDay(), " day of ", getMonth(), ", 20", year, "."
