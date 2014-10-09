import rdstdin, strutils
let number = parseInt readLineFromStdin "Enter a number between 0 and 32767: "
echo "In octal, your number is: ", number.toOct(5)
