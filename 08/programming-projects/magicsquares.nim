import rdstdin, sequtils, strfmt, strutils

echo """
This program creates a magic square of a specified size.
The size must be an odd number between 1 and 99."""
let
  size = parseInt readLineFromStdin "Enter size of magic square: "
  middle = ((size - 1) / 2).toInt

type TPoint = tuple[x, y: int]

var
  magicSquare = newSeqWith(size, newSeqWith(size, 0))
  points = newSeq[TPoint](size * size)

for i in 0 .. <points.len:
  points[i].x = -32323
  points[i].y = -32323
points[0].x = middle
points[0].y = 0

proc haveSeen(x: int, y: int): bool =
  for i in 0 .. <points.len:
    if x == points[i].x and y == points[i].y:
      return true
  return false

proc genPoint(basePoint: TPoint = points[0]): TPoint =
  var
    x = basePoint.x
    y = basePoint.y
  if (y - 1) < 0: y = size - 1 else: y -= 1
  if (x + 1) > (size - 1): x = 0 else: x += 1
  if haveSeen(x, y):
    x = basePoint.x
    y = basePoint.y
    if (y + 1) > (size - 1): y = 0 else: y += 1
  (x, y)

while true:
  if points.len == 1: break
  for i in 1 .. <points.len:
    points[i] = genPoint(points[i - 1])
  break

for i in 0 .. <points.len:
  magicSquare[points[i].x][points[i].y] = i + 1

var magicSquares = newSeqWith(magicSquare.len, newSeqWith(magicSquare.len, 0))
for i in 0 .. <magicSquare.len:
  for k,v in magicSquare:
    magicSquares[i][k] = v[i]

for i in 0 .. <magicSquares.len:
  for j in 0 .. <magicSquares[i].len:
    stdout.write magicSquares[i][j].format ">4"
    if j < magicSquares[i].len - 1: stdout.write " "
  stdout.write "\n"
