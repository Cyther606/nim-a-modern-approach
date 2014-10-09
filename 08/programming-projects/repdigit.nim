import rdstdin, sequtils, strutils

let number = readLineFromStdin("Enter a number: ").strip

proc rp(n = number): string =
  result = ""
  var
    m = ""
    o = ""

  for i in 0 .. <n.len:
    if m.contains n[i]:
      o = o & n[i] & " "
    m = m & n[i]

  for i in 0 .. <o.split.deduplicate.len:
    result = result & o.split.deduplicate[i]
    if i < o.split.deduplicate.len - 1: result = result & " "

echo "Repeated digit(s): ", rp()
