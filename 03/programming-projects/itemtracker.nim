import rdstdin, strutils

let
  item = parseInt readLineFromStdin "Enter item number: "
  price = parseFloat readLineFromStdin "Enter unit price: "
  pricel = $price
  date = readLineFromStdin("Enter purchase date (mm/dd/yyyy): ").split('/').map(parseInt)
  month = date[0]
  day = date[1]
  year = date[2]

echo format("""
Item$6Unit $7Purchase
  $8Price$9Date
$1  $10$$$2 $11$3$4$5""",
  item,
  repeatChar(max(0, 7 - pricel.len)) & price.formatFloat(ffDecimal, 2),
  month.intToStr(2) & "/", day.intToStr(2) & "/", year,
  "\t\t", "\t\t", "\t\t", "\t\t", "\t\t", "\t")
