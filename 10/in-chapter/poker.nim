import algorithm, rdstdin, sequtils

# Classifies a poker hand

# definitions
const
  RANKS = 13
  SUITS = 4
  CARDS = 5

# external variables
var
  hand = newSeq[seq[int]](CARDS)
  numInRank: array[RANKS, int]
  numInSuit: array[SUITS, int]
  cardExists: array[RANKS, array[SUITS, bool]]
  royal, flush, straight, wheel, four, three: bool
  pairs: int # can be 0, 1, or 2
for i in 0 .. <CARDS: hand[i].newSeq(2)

# prototypes
proc readCards()
proc analyzeHand()
proc sortHand()
proc printResult()


#**********************************************************
#  main: Calls readCards, analyzeHand, sortHand, and      *
#        printResult repeatedly.                          *
#**********************************************************
proc main() =
  while true:
    readCards()
    analyzeHand()
    sortHand()
    printResult()


#**********************************************************
#  readCards:  Reads the cards into the external          *
#              variable cardExists and hand; checks for   *
#              bad cards and duplicate cards.             *
#**********************************************************
proc readCards() =
  var
    rankChar, suitChar: char
    rank, suit: int
    badCard, duplicateCard: bool
    cardsRead = 0

  rank = 0
  while rank < RANKS:
    numInRank[rank] = 0
    suit = 0
    while suit < SUITS:
      cardExists[rank][suit] = false
      inc suit
    inc rank

  suit = 0
  while suit < SUITS:
    numInSuit[suit] = 0
    inc suit

  while cardsRead < CARDS:
    badCard = false
    let chs = readLineFromStdin "Enter a card: "

    rankChar = chs[0]
    case rankChar
    of '0': quit()
    of '2': rank = 0
    of '3': rank = 1
    of '4': rank = 2
    of '5': rank = 3
    of '6': rank = 4
    of '7': rank = 5
    of '8': rank = 6
    of '9': rank = 7
    of 't', 'T': rank = 8
    of 'j', 'J': rank = 9
    of 'q', 'Q': rank = 10
    of 'k', 'K': rank = 11
    of 'a', 'A': rank = 12
    else: badCard = true

    suitChar = chs[1]
    case suitChar
    of 'c', 'C': suit = 0
    of 'd', 'D': suit = 1
    of 'h', 'H': suit = 2
    of 's', 'S': suit = 3
    else: badCard = true

    for i in 2 .. <chs.len:
      if chs[i] != '\x0A' and chs[i] != ' ':
        badCard = true

    if badCard:
      echo "Bad card; ignored."
      continue

    duplicateCard = false
    for i in 0 .. <cardsRead:
      if hand[i][0] == rank and hand[i][1] == suit:
        echo "Duplicate card; ignored."
        duplicateCard = true
        break
    if not duplicateCard:
      hand[cardsRead][0] = rank
      hand[cardsRead][1] = suit
      inc numInRank[rank]
      inc numInSuit[suit]
      cardExists[rank][suit] = true
      inc cardsRead


#**********************************************************
#  analyzeHand:  Determines whether the hand contains a   *
#                straight, a flush, four-of-a-kind,       *
#                and/or three-of-a-kind; determines the   *
#                number of pairs; stores the results into *
#                the external variables royal, flush,     *
#                straight, wheel, four, three, and pairs. *
#**********************************************************
proc analyzeHand() =
  var
    rank, suit: int
    numConsec = 0

  royal = false
  flush = false
  straight = false
  wheel = false
  four = false
  three = false
  pairs = 0

  # check for flush
  suit = 0
  while suit < SUITS:
    if numInSuit[suit] == CARDS:
      if cardExists[8][suit] and
        cardExists[9][suit] and
        cardExists[10][suit] and
        cardExists[11][suit] and
        cardExists[12][suit]:
        royal = true
      flush = true
    inc suit

  # check for straight
  rank = 0
  while numInRank[rank] == 0: inc rank
  while rank < RANKS and numInRank[rank] > 0:
    inc numConsec
    inc rank
  if numConsec == CARDS:
    straight = true
  elif numConsec == CARDS - 1 and
    numInRank[0] > 0 and
    numInRank[RANKS - 1] > 0:
    straight = true
    wheel = true

  # check for 4-of-a-kind, 3-of-a-kind, and pairs
  rank = 0
  while rank < RANKS:
    if numInRank[rank] == 4: four = true
    if numInRank[rank] == 3: three = true
    if numInRank[rank] == 2: inc pairs
    inc rank


#**********************************************************
#  sortHand:     Sorts hand semantically, with each       *
#                component listed in descending order of  *
#                valuation.                               *
#**********************************************************
proc sortHand() =
  var
    pass, run: int
    rank, suit, thisCard: int
    matchTwo = newSeq[seq[int]]()
    matchThree = newSeq[seq[int]]()
    matchFour = newSeq[seq[int]]()
    handRemaining: seq[seq[int]]
    handSorted = newSeq[seq[int]]()

  # sort cards by rank in ascending order
  pass = 1
  while pass < CARDS:
    thisCard = 0
    while thisCard < CARDS - pass:
      rank = hand[thisCard][0]
      suit = hand[thisCard][1]
      if hand[thisCard + 1][0] < rank:
        hand[thisCard][0] = hand[thisCard + 1][0]
        hand[thisCard][1] = hand[thisCard + 1][1]
        hand[thisCard + 1][0] = rank
        hand[thisCard + 1][1] = suit
      inc thisCard
    inc pass

  handRemaining = hand

  if four:
    run = 0
    for i in 0 .. <hand.high - 2:
      if hand[i][0] == hand[i + 3][0]:
        matchFour.add hand.filter do (x: seq[int]) -> bool: x[0] == hand[i][0]
        inc run
    for i in 0 .. <matchFour.len:
      for k,v in handRemaining:
        if v == matchFour[i]:
          handRemaining.delete(k, k)
    handSorted.add matchFour.reversed
    handSorted.add handRemaining.reversed
    hand = handSorted
  elif three and pairs >= 1:
    run = 0
    for i in 0 .. <hand.high - 1:
      if hand[i][0] == hand[i + 2][0]:
        matchThree.add hand.filter do (x: seq[int]) -> bool: x[0] == hand[i][0]
        inc run
    for i in 0 .. <matchThree.len:
      for k,v in handRemaining:
        if v == matchThree[i]:
          handRemaining.delete(k, k)
    for i in 0 .. <handRemaining.high:
      if handRemaining[i][0] == handRemaining[i + 1][0]:
        matchTwo.add handRemaining.filter do (x: seq[int]) -> bool:
          x[0] == handRemaining[i][0]
        inc run
    for i in 0 .. <matchTwo.len:
      for k,v in handRemaining:
        if v == matchTwo[i]:
          handRemaining.delete(k, k)
    handSorted.add matchThree.reversed
    handSorted.add matchTwo.reversed
    handSorted.add handRemaining.reversed
    hand = handSorted
  elif wheel:
    hand.insert(hand[hand.high], 0)
    hand.delete(hand.high, hand.high)
  elif royal or flush or straight:
    handSorted = hand
  elif three:
    run = 0
    for i in 0 .. <hand.high - 1:
      if hand[i][0] == hand[i + 2][0]:
        matchThree.add hand.filter do (x: seq[int]) -> bool: x[0] == hand[i][0]
        inc run
    for i in 0 .. <matchThree.len:
      for k,v in handRemaining:
        if v == matchThree[i]:
          handRemaining.delete(k, k)
    handSorted.add matchThree.reversed
    handSorted.add handRemaining.reversed
    hand = handSorted
  elif pairs >= 1:
    run = 0
    for i in 0 .. <hand.high:
      if hand[i][0] == hand[i + 1][0]:
        matchTwo.add hand.filter do (x: seq[int]) -> bool: x[0] == hand[i][0]
        inc run
    for i in 0 .. <matchTwo.len:
      for k,v in handRemaining:
        if v == matchTwo[i]:
          handRemaining.delete(k, k)
    handSorted.add matchTwo.reversed
    handSorted.add handRemaining.reversed
    hand = handSorted
  else:
    hand.reverse


#**********************************************************
#  printResult:  Prints the classification of the hand,   *
#                based on the values of the external      *
#                variables royal, flush, straight, wheel, *
#                four, three, and pairs.                  *
#**********************************************************
proc printResult() =
  var
    displayRank, displaySuit, displayCard: string
    displayHand = newSeq[string]()

  for i in 0 .. <hand.len:
    case hand[i][0]
    of 0: displayRank = "2"
    of 1: displayRank = "3"
    of 2: displayRank = "4"
    of 3: displayRank = "5"
    of 4: displayRank = "6"
    of 5: displayRank = "7"
    of 6: displayRank = "8"
    of 7: displayRank = "9"
    of 8: displayRank = "T"
    of 9: displayRank = "J"
    of 10: displayRank = "Q"
    of 11: displayRank = "K"
    of 12: displayRank = "A"
    else: discard
    case hand[i][1]
    of 0: displaySuit = "c"
    of 1: displaySuit = "d"
    of 2: displaySuit = "h"
    of 3: displaySuit = "s"
    else: discard
    displayCard = displayRank & displaySuit
    displayHand.add displayCard

  proc printHand() =
    stdout.write "["
    for i in 0 .. <displayHand.len:
      stdout.write displayHand[i]
      if i < displayHand.len - 1: stdout.write ", "
    echo "]"

  if royal:
    stdout.write "Royal flush: "
    printHand()
  elif straight and flush:
    stdout.write "Straight flush: "
    printHand()
  elif four:
    stdout.write "Four of a kind: "
    printHand()
  elif three and pairs == 1:
    stdout.write "Full house: "
    printHand()
  elif flush:
    stdout.write "Flush: "
    printHand()
  elif straight:
    stdout.write "Straight: "
    printHand()
  elif three:
    stdout.write "Three of a kind: "
    printHand()
  elif pairs == 2:
    stdout.write "Two pairs: "
    printHand()
  elif pairs == 1:
    stdout.write "Pair: "
    printHand()
  else:
    stdout.write "High card: "
    printHand()
  echo ""

main()
