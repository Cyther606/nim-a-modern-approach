import rdstdin, strutils, times

var
  dates = newSeq[string]()
  time = newSeq[TTime]()

while true:
  let date = readLineFromStdin("Enter a date (mm/dd/yyyy): ").split('/').map(parseInt)
  if date[0] == 0 and date[1] == 0 and date[2] == 0: break
  else:
    let datestring = $date[0] & "/" & $date[1] & "/" & $date[2]
    dates = dates & datestring
    time = time & TTimeInfo(monthday: date[1],
                            month: TMonth(date[0] - 1),
                            year: date[2]).timeInfoToTime

for k,v in time:
  if v == time.min:
    echo dates[k], " is the earliest date"
