import math, sequtils, times

var
  alphabet: array[26, string] = ["A", "B", "C", "D", "E", "F",
                                 "G", "H", "I", "J", "K", "L",
                                 "M", "N", "O", "P", "Q", "R",
                                 "S", "T", "U", "V", "W", "X",
                                 "Y", "Z"]
  points: array[26, tuple[x: int, y: int]] = [(0, 0), (0, 0), (0, 0), (0, 0),
                                              (0, 0), (0, 0), (0, 0), (0, 0),
                                              (0, 0), (0, 0), (0, 0), (0, 0),
                                              (0, 0), (0, 0), (0, 0), (0, 0),
                                              (0, 0), (0, 0), (0, 0), (0, 0),
                                              (0, 0), (0, 0), (0, 0), (0, 0),
                                              (0, 0), (0, 0)]
  grid: array[10, array[10, string]] = [[".", ".", ".", ".", ".",
                                         ".", ".", ".", ".", "."],
                                        [".", ".", ".", ".", ".",
                                         ".", ".", ".", ".", "."],
                                        [".", ".", ".", ".", ".",
                                         ".", ".", ".", ".", "."],
                                        [".", ".", ".", ".", ".",
                                         ".", ".", ".", ".", "."],
                                        [".", ".", ".", ".", ".",
                                         ".", ".", ".", ".", "."],
                                        [".", ".", ".", ".", ".",
                                         ".", ".", ".", ".", "."],
                                        [".", ".", ".", ".", ".",
                                         ".", ".", ".", ".", "."],
                                        [".", ".", ".", ".", ".",
                                         ".", ".", ".", ".", "."],
                                        [".", ".", ".", ".", ".",
                                         ".", ".", ".", ".", "."],
                                        [".", ".", ".", ".", ".",
                                         ".", ".", ".", ".", "."]]

randomize()

proc genPoint(basePoint: tuple[x: int, y: int]): tuple[x: int, y: int] =
  var
    x = basePoint.x
    y = basePoint.y
  let r = random(4)
  case r
  of 0: y += 1
  of 1: x += 1
  of 2: y -= 1
  of 3: x -= 1
  else: discard
  (x, y)

proc haveSeen(x: int, y: int): bool =
  for i in 0 .. <points.len:
    if x == points[i].x and y == points[i].y:
      return true
  return false

var
  thisPoint: tuple[x: int, y: int]
  t0 = cpuTime()
  blocked = false

block gen:
  for i in 1 .. <points.len:
    while true:
      thisPoint = genPoint(points[i - 1])
      if thisPoint.x < 0 or
        thisPoint.x > 9 or
        thisPoint.y < 0 or
        thisPoint.y > 9:
        continue
      elif haveSeen(thisPoint.x, thisPoint.y):
        if cpuTime() - t0 > 0.1:
          blocked = true
          break gen
        else: continue
      else:
        points[i] = thisPoint
        break

for i in 0 .. <points.len:
  grid[points[i].x][points[i].y] = alphabet[i]

if blocked: grid[points[0].x][points[0].y] = "A"

for i in 0 .. <grid.len:
  for j in 0 .. <grid[i].len:
    stdout.write grid[i][j]
    if j < grid[i].high: stdout.write "  "
    else: stdout.write "\n"
