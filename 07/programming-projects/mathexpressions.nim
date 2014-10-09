import osproc, rdstdin, strfmt
var expression = readLineFromStdin "Enter an expression: "
stdout.write "Value of expression: ", execCmdEx(interp"perl -e 'printf $expression'").output
