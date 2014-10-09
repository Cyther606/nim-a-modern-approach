import strutils

const
  i = 40
  il = $i
  x = 839.21
  xl = $x

echo "using nim procs:"
echo "|", $i, "|", align($i, 5), "|",
  $i, repeatChar(max(0, 5 - il.len)), "|",
  align(intToStr(i, 3), 5), "|"
echo "|", align(x.formatFloat(ffDecimal, 3), 10), "|",
  align(x.formatFloat(ffScientific, 3), 10), "|",
  $x, repeatChar(max(0, 10 - xl.len)), "|"
echo ""
echo "using printf imported from c:"
proc printf(formatstr: cstring) {.header: "<stdio.h>", varargs.}
printf("|%d|%5d|%-5d|%5.3d|\n", i, i, i, i)
printf("|%10.3f|%10.3e|%-10g|\n", x, x, x)
