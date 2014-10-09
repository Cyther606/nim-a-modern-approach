import rdstdin, strutils

let number = parseFloat readLineFromStdin "Enter a positive number: "

proc newton(x = number): float =
  var
    x = x
    y = 1.0
    a = 0.00001 * y
    x_div_y = x / y
    avg_y_and_x_div_y = (y + x_div_y) / 2

  while abs(y - avg_y_and_x_div_y) >= a:
    y = avg_y_and_x_div_y
    x_div_y = x / y
    avg_y_and_x_div_y = (y + x_div_y) / 2

  result = avg_y_and_x_div_y

echo "Square root: ", newton()
