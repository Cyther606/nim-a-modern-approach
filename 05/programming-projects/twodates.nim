import rdstdin, strutils, times

let
  dateA = readLineFromStdin("Enter first date (mm/dd/yyyy): ").split('/').map(parseInt)
  dateB = readLineFromStdin("Enter second date (mm/dd/yyyy): ").split('/').map(parseInt)
  timeA = TTimeInfo(monthday: dateA[1],
                    month: TMonth(dateA[0] - 1),
                    year: dateA[2])
  timeB = TTimeInfo(monthday: dateB[1],
                    month: TMonth(dateB[0] - 1),
                    year: dateB[2])

if timeInfoToTime(timeA) < timeInfoToTime(timeB):
  echo dateA[0], "/", dateA[1], "/", dateA[2], " is earlier than ",
    dateB[0], "/", dateB[1], "/", dateB[2]
else:
  echo dateB[0], "/", dateB[1], "/", dateB[2], " is earlier than ",
    dateA[0], "/", dateA[1], "/", dateA[2]
