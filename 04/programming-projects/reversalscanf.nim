var n1, n2, n3: int
proc scanf(frmt: cstring) {.varargs, importc, header: "<stdio.h>".}
stdout.write "Enter a two-digit number: "
scanf("%1d%1d", addr n2, addr n1)
echo "The reversal is: ", n1, n2
stdout.write "Enter a three-digit number: "
scanf("%1d%1d%1d", addr n3, addr n2, addr n1)
echo "The reversal is: ", n1, n2, n3
