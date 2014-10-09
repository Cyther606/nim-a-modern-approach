import rdstdin
from strutils import parseInt

const INCHES_PER_POUND = 166

let
  length = parseInt readLineFromStdin "Enter length of box: "
  width = parseInt readLineFromStdin "Enter width of box: "
  height = parseInt readLineFromStdin "Enter height of box: "

echo "Volume (cubic inches): ", length * width * height
echo "Dimensional weight (pounds): ", (length * width * height) / INCHES_PER_POUND
