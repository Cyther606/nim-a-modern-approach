import rdstdin, strutils

let
  isbn = readLineFromStdin("Enter ISBN: ").split('-').map(parseInt)
  gs1_prefix = isbn[0]
  group_id = isbn[1]
  publisher_code = isbn[2]
  item_number = isbn[3]
  check_digit = isbn[4]

echo format("""
GS1 prefix: $#
Group identifier: $#
Publisher code: $#
Item number: $#
Check digit: $#""",
  gs1_prefix,
  group_id,
  publisher_code,
  item_number,
  check_digit)
