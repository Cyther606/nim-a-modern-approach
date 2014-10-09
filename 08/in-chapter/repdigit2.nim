import rdstdin, strutils

let number = readLineFromStdin("Enter a number: ").strip

proc rp(n = number): bool =
  var
    n = n
    m = ""

  for i in 0 .. <n.len:
    if m.contains n[i]: return true
    else: m = m & n[i]

  return false

echo if rp(): "Repeated digit" else: "No digit repeats"
