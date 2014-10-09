import rdstdin, strutils

var balance = 0.0

echo """
*** ACME checkbook-balancing program ***
Commands: 0=clear, 1=credit, 2=debit, 3=balance, 4=exit
"""

proc runCheckbook() =
  block checking:
    while true:
      let command = parseInt readLineFromStdin "Enter command: "
      case command
      of 0:
        echo "Reseting balance"
        balance = 0.0
      of 1:
        balance = balance + parseFloat readLineFromStdin "Enter amount of credit: "
      of 2:
        balance = balance - parseFloat readLineFromStdin "Enter amount of debit: "
      of 3:
        echo "Current balance: $", balance.formatFloat(ffDecimal, 2)
      of 4:
        echo "Exiting"
        break checking
      else: runCheckbook()

runCheckbook()
