import rdstdin, strutils

let grade = parseInt readLineFromStdin "Enter numerical grade: "

proc getGrade(grade: int = grade): string =
  case grade
  of 90..100: "A"
  of 80..89: "B"
  of 70..79: "C"
  of 60..69: "D"
  of 0..59: "F"
  else: "(Error: grade cannot be larger than 100 or less than 0)"

echo "Letter grade: ", getGrade()
