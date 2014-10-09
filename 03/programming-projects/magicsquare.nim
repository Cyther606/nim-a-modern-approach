import rdstdin, strutils

# magic square: 16 3 2 13 5 10 11 8 9 6 7 12 4 15 14 1
let
  nums = readLineFromStdin("Enter the numbers from 1 to 16 in any order: ").split
  numsi = nums.map(parseInt)
  numsl = nums.map(proc (s: string): int = s.len)

echo format("""
$# $# $# $#
$# $# $# $#
$# $# $# $#
$# $# $# $#
""",
  repeatChar(max(0,2 - numsl[0])) & nums[0],
  repeatChar(max(0,2 - numsl[1])) & nums[1],
  repeatChar(max(0,2 - numsl[2])) & nums[2],
  repeatChar(max(0,2 - numsl[3])) & nums[3],
  repeatChar(max(0,2 - numsl[4])) & nums[4],
  repeatChar(max(0,2 - numsl[5])) & nums[5],
  repeatChar(max(0,2 - numsl[6])) & nums[6],
  repeatChar(max(0,2 - numsl[7])) & nums[7],
  repeatChar(max(0,2 - numsl[8])) & nums[8],
  repeatChar(max(0,2 - numsl[9])) & nums[9],
  repeatChar(max(0,2 - numsl[10])) & nums[10],
  repeatChar(max(0,2 - numsl[11])) & nums[11],
  repeatChar(max(0,2 - numsl[12])) & nums[12],
  repeatChar(max(0,2 - numsl[13])) & nums[13],
  repeatChar(max(0,2 - numsl[14])) & nums[14],
  repeatChar(max(0,2 - numsl[15])) & nums[15])
echo "Row sums: ",
  numsi[0] + numsi[1] + numsi[2] + numsi[3], " ",
  numsi[4] + numsi[5] + numsi[6] + numsi[7], " ",
  numsi[8] + numsi[9] + numsi[10] + numsi[11], " ",
  numsi[12] + numsi[13] + numsi[14] + numsi[15]
echo "Column sums: ",
  numsi[0] + numsi[4] + numsi[8] + numsi[12], " ",
  numsi[1] + numsi[5] + numsi[9] + numsi[13], " ",
  numsi[2] + numsi[6] + numsi[10] + numsi[14], " ",
  numsi[3] + numsi[7] + numsi[11] + numsi[15]
echo "Diagonal sums: ",
  numsi[0] + numsi[5] + numsi[10] + numsi[15], " ",
  numsi[12] + numsi[9] + numsi[6] + numsi[3]
