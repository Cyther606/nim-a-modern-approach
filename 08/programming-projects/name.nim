import rdstdin, strutils
let firstlast = readLineFromStdin("Enter a first and last name: ").strip.split
echo "You entered the name: ", firstlast[1], ", ", firstlast[0][0], "."
