var
  category: int
  m1, m2, m3, m4, m5: int
  p1, p2, p3, p4, p5: int
  check: int

proc scanf(frmt: cstring) {.varargs, importc, header: "<stdio.h>".}

proc verifyUPC(category: int = category,
               m1: int = m1,
               m2: int = m2,
               m3: int = m3,
               m4: int = m4,
               m5: int = m5,
               p1: int = p1,
               p2: int = p2,
               p3: int = p3,
               p4: int = p4,
               p5: int = p5,
               check: int = check): bool =
  let
    sum1 = category + m2 + m4 + p1 + p3 + p5
    sum2 = m1 + m3 + m5 + p2 + p4
    total = 9 - ((3 * sum1 + sum2 - 1) mod 10)
  if total == check: return true else: return false

stdout.write "Enter the first (single) digit: "
scanf("%1d", addr category)
stdout.write "Enter first group of five digits: "
scanf("%1d%1d%1d%1d%1d", addr m1, addr m2, addr m3, addr m4, addr m5)
stdout.write "Enter second group of five digits: "
scanf("%1d%1d%1d%1d%1d", addr p1, addr p2, addr p3, addr p4, addr p5)
stdout.write "Check digit: "
scanf("%1d", addr check)

echo "Check digit ", if verifyUPC(): "matches" else: "does not match"
