import rdstdin, strutils
let phone = readLineFromStdin("Enter phone number [(xxx) xxx-xxxx]: ").split({'(', ')', '-', ' '})
echo "You entered ", phone[0], ".", phone[1], ".", phone[2]
