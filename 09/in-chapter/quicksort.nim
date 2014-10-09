import rdstdin, strutils

let numbers = readLineFromStdin("Enter 10 numbers to be sorted: ").split.map(parseInt)

proc sort(nums: seq[int]): seq[int] =
  var j, t: int
  result = nums
  for i in 0 .. <result.len:
    j = i
    t = result[j]
    while(j > 0) and (result[j - 1] > t):
      result[j] = result[j - 1]
      dec(j)
    result[j] = t

for i in 0 .. <numbers.sort.len:
  stdout.write numbers.sort[i]
  if i < numbers.sort.len - 1: stdout.write " "
echo ""
