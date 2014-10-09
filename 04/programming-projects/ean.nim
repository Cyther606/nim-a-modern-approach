var
  m1, m2, m3, m4, m5, m6: int
  p1, p2, p3, p4, p5, p6: int

proc scanf(frmt: cstring) {.varargs, importc, header: "<stdio.h>".}

proc verifyUPC(m1: int = m1,
               m2: int = m2,
               m3: int = m3,
               m4: int = m4,
               m5: int = m5,
               m6: int = m6,
               p1: int = p1,
               p2: int = p2,
               p3: int = p3,
               p4: int = p4,
               p5: int = p5,
               p6: int = p6): int =
  let
    sum1 = m2 + m4 + m6 + p2 + p4 + p6
    sum2 = m1 + m3 + m5 + p1 + p3 + p5
    total = 9 - ((3 * sum1 + sum2 - 1) mod 10)
  result = total

stdout.write "Enter the first 12 digits of an EAN: "
scanf("%1d%1d%1d%1d%1d%1d%1d%1d%1d%1d%1d%1d",
  addr m1, addr m2, addr m3, addr m4, addr m5, addr m6,
  addr p1, addr p2, addr p3, addr p4, addr p5, addr p6)

echo "Check digit: ", verifyUPC()
