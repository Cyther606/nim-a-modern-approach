import rdstdin, strutils

let
  date = readLineFromStdin("Enter a date (mm/dd/yyyy): ").split('/').map(parseInt)
  month = date[0]
  day = date[1]
  year = date[2]

echo "You entered the date ", year, month.intToStr(2), day.intToStr(2)
