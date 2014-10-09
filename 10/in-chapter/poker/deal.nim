import math, os, sequtils, strutils

let
  cardsDealt = commandLineParams().map(parseInt)[0]
  suits: array[4, string] = ["c", "d", "h", "s"]
  ranks: array[13, string] = ["2", "3", "4", "5", "6", "7", "8",
                              "9", "T", "J", "Q", "K", "A"]

var
  cards = newSeq[string]()
  thisCard: string
for i in 0 .. <suits.len:
  for r in 0 .. <ranks.len:
    thisCard = ranks[r] & suits[i]
    cards = cards & thisCard

randomize()

proc showHand(cards = cards): string =
  result = ""
  var
    cards = cards
    index: int
  for i in 0 .. <cardsDealt:
    index = random(52 - i)
    result = result & cards[index]
    if i < cardsDealt - 1: result = result & " "
    cards.delete(index, index)

echo showHand()
