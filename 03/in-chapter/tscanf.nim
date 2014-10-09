import rdstdin, strutils

var
  i, j: int
  x, y: float

echo "using nim procs:"
let nums = readLineFromStdin("Enter two ints followed by two floats, use spaces to separate: ").split
echo "i: ", nums[0].parseInt
echo "j: ", nums[1].parseInt
echo "x: ", nums[2].parseFloat
echo "y: ", nums[3].parseFloat
echo ""
echo "using scanf imported from c:"
proc scanf(frmt: cstring) {.varargs, importc, header: "<stdio.h>".}
stdout.write "Enter two ints followed by two floats, use spaces to separate: "
scanf("%ld%ld%lf%lf", addr i, addr j, addr x, addr y)
echo "i: ", i
echo "j: ", j
echo "x: ", x
echo "y: ", y
