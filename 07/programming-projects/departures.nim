import rdstdin, strutils

let
  time12 = readLineFromStdin "Enter a time (hours:minutes [AM|PM]): "
  flights: array[8, tuple[since: int,
                          depart: string,
                          arrive: string]] = [(480, "8:00 a.m.", "10:16 a.m."),
                                              (583, "9:43 a.m.", "11:52 a.m."),
                                              (679, "11:19 a.m.", "1:31 p.m."),
                                              (767, "12:47 p.m.", "3:00 p.m."),
                                              (840, "2:00 p.m.", "4:08 p.m."),
                                              (945, "3:45 p.m.", "5:55 p.m."),
                                              (1140, "7:00 p.m.", "9:20 p.m."),
                                              (1305, "9:45 p.m.", "11:58 p.m.")]

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

let
  hours24 = getTime24().hours24
  minutes24 = getTime24().minutes24

proc minutesSinceMidnight(hours: int = hours24, minutes: int = minutes24): int =
  hours * 60 + minutes

proc cmpFlights(m = minutesSinceMidnight()): seq[int] =
  result = newSeq[int](flights.len)
  for i in 0 .. <flights.len:
    result[i] = abs(m - flights[i].since)

proc getClosest(): int =
  for k,v in cmpFlights():
    if v == cmpFlights().min: return k

echo "Closest departure time is ", flights[getClosest()].depart,
  ", arriving at ", flights[getClosest()].arrive
