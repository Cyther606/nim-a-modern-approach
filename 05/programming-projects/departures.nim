import rdstdin, strutils

let
  time24 = readLineFromStdin("Enter a 24-hour time: ").split(':').map(parseInt)
  hours24 = time24[0]
  minutes24 = time24[1]
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
