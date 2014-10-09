import rdstdin, strutils
let firstlast = readLineFromStdin("Enter a first and last name: ").strip.split
echo firstlast[1], ", ", firstlast[0][0], "."
