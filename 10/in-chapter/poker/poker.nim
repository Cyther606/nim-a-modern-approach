import algorithm, os, sequtils

# Classifies a poker hand

# definitions
const
  RANKS = 13
  SUITS = 4

let inputCards = commandLineParams()

# utility procs
proc `^`(base: int; exp: int): int64 =
  # basic exponentiation
  # needed for calculating hand value
  var exp = exp
  result = 1
  while exp > 0:
    result *= base
    dec exp

proc dedup(seq0: seq[seq[int]]): seq[seq[int]] =
  # given seq0, returns seq0 with no more than one occurrence of seq0[X][0]
  # needed for straights and wheels (non straight-flush) due to the
  # possibility of @[@[2, 1], @[2, 2], @[3, 1]] ...
  var seq3 = newSeq[seq[int]]()
  proc threadUniqs(seq1: seq[seq[int]], i: int): seq[int] =
    var seq2 = newSeq[seq[int]]()
    seq2.add seq1.filter do (x: seq[int]) -> bool: x[0] == seq1[i][0]
    return seq2[seq2.high]
  for i in 0 .. <seq0.len: seq3.add seq0.threadUniqs(i)
  return seq3.deduplicate


#**********************************************************
#  readCards:  Reads the cards into the external          *
#              variable cardExists and hand; checks for   *
#              bad cards and duplicate cards.             *
#**********************************************************
proc readCards(inputCards = inputCards): tuple[hand: seq[seq[int]],
                                               numInRank: array[RANKS, int],
                                               numInSuit: array[SUITS, int],
                                               cardExists: array[RANKS, array[SUITS, bool]]] =
  var
    hand = newSeq[seq[int]](0)
    numInRank: array[RANKS, int]
    numInSuit: array[SUITS, int]
    cardExists: array[RANKS, array[SUITS, bool]]
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

  while cardsRead < inputCards.len:
    badCard = false
    let chs = inputCards[cardsRead]

    rankChar = chs[0]
    case rankChar
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
      echo "ERROR: Bad card"
      quit(1)

    duplicateCard = false
    for i in 0 .. <cardsRead:
      if hand[i][0] == rank and hand[i][1] == suit:
        echo "ERROR: Duplicate card"
        duplicateCard = true
        quit(1)
    if not duplicateCard:
      hand.add(@[rank, suit])
      inc numInRank[rank]
      inc numInSuit[suit]
      cardExists[rank][suit] = true
      inc cardsRead

  (hand, numInRank, numInSuit, cardExists)


#**********************************************************
#  analyzeHand:  Determines whether the hand contains a   *
#                straight, a flush, four-of-a-kind,       *
#                and/or three-of-a-kind; determines the   *
#                number of pairs; stores the results into *
#                the external variables royal, flush,     *
#                straight, wheel, four, three, trips and  *
#                pairs.                                   *
#**********************************************************
proc analyzeHand(hand = readCards().hand,
                 numInRank = readCards().numInRank,
                 numInSuit = readCards().numInSuit,
                 cardExists = readCards().cardExists): tuple[royal,
                                                             straightFlush,
                                                             flush,
                                                             straight,
                                                             wheel,
                                                             four,
                                                             three: bool,
                                                             trips,
                                                             pairs: int] =
  var
    royal, straightFlush, flush, straight, wheel, four, three = false
    pairs, trips = 0
    rank, suit: int

  # check for flush, royal flush and straight flush
  suit = 0
  while suit < SUITS:
    if numInSuit[suit] >= 5:
      if   (cardExists[8][suit] and
            cardExists[9][suit] and
            cardExists[10][suit] and
            cardExists[11][suit] and
            cardExists[12][suit]):
        royal = true
      elif (cardExists[7][suit] and
            cardExists[8][suit] and
            cardExists[9][suit] and
            cardExists[10][suit] and
            cardExists[11][suit]) or
           (cardExists[6][suit] and
            cardExists[7][suit] and
            cardExists[8][suit] and
            cardExists[9][suit] and
            cardExists[10][suit]) or
           (cardExists[5][suit] and
            cardExists[6][suit] and
            cardExists[7][suit] and
            cardExists[8][suit] and
            cardExists[9][suit]) or
           (cardExists[4][suit] and
            cardExists[5][suit] and
            cardExists[6][suit] and
            cardExists[7][suit] and
            cardExists[8][suit]) or
           (cardExists[3][suit] and
            cardExists[4][suit] and
            cardExists[5][suit] and
            cardExists[6][suit] and
            cardExists[7][suit]) or
           (cardExists[2][suit] and
            cardExists[3][suit] and
            cardExists[4][suit] and
            cardExists[5][suit] and
            cardExists[6][suit]) or
           (cardExists[1][suit] and
            cardExists[2][suit] and
            cardExists[3][suit] and
            cardExists[4][suit] and
            cardExists[5][suit]) or
           (cardExists[0][suit] and
            cardExists[1][suit] and
            cardExists[2][suit] and
            cardExists[3][suit] and
            cardExists[4][suit]) or
           (cardExists[12][suit] and
            cardExists[0][suit] and
            cardExists[1][suit] and
            cardExists[2][suit] and
            cardExists[3][suit]):
        straightFlush = true
      flush = true
    inc suit

  # check for straight
  if   (numInRank[12] > 0 and
        numInRank[0] > 0 and
        numInRank[1] > 0 and
        numInRank[2] > 0 and
        numInRank[3] > 0):
    wheel = true
    straight = true
  elif (numInRank[8] > 0 and
        numInRank[9] > 0 and
        numInRank[10] > 0 and
        numInRank[11] > 0 and
        numInRank[12] > 0) or
       (numInRank[7] > 0 and
        numInRank[8] > 0 and
        numInRank[9] > 0 and
        numInRank[10] > 0 and
        numInRank[11] > 0) or
       (numInRank[6] > 0 and
        numInRank[7] > 0 and
        numInRank[8] > 0 and
        numInRank[9] > 0 and
        numInRank[10] > 0) or
       (numInRank[5] > 0 and
        numInRank[6] > 0 and
        numInRank[7] > 0 and
        numInRank[8] > 0 and
        numInRank[9] > 0) or
       (numInRank[4] > 0 and
        numInRank[5] > 0 and
        numInRank[6] > 0 and
        numInRank[7] > 0 and
        numInRank[8] > 0) or
       (numInRank[3] > 0 and
        numInRank[4] > 0 and
        numInRank[5] > 0 and
        numInRank[6] > 0 and
        numInRank[7] > 0) or
       (numInRank[2] > 0 and
        numInRank[3] > 0 and
        numInRank[4] > 0 and
        numInRank[5] > 0 and
        numInRank[6] > 0) or
       (numInRank[1] > 0 and
        numInRank[2] > 0 and
        numInRank[3] > 0 and
        numInRank[4] > 0 and
        numInRank[5] > 0) or
       (numInRank[0] > 0 and
        numInRank[1] > 0 and
        numInRank[2] > 0 and
        numInRank[3] > 0 and
        numInRank[4] > 0):
    straight = true

  # check for 4-of-a-kind, 3-of-a-kind, and pairs
  rank = 0
  while rank < RANKS:
    if numInRank[rank] == 4:
      four = true
    if numInRank[rank] == 3:
      three = true
      inc trips
    if numInRank[rank] == 2:
      inc pairs
    inc rank

  (royal, straightFlush, flush, straight, wheel, four, three, trips, pairs)


#**********************************************************
#  orderHand:    Orders cards by rank ascending, then by  *
#                suit ascending if ranks are equal        *
#**********************************************************
proc orderHand(hand = readCards().hand): seq[seq[int]] =
  var handOrdered = hand
  proc hcmp(x, y): int =
    result = cmp(x[0], y[0])
    if result == 0: result = cmp(x[1], y[1])
  handOrdered.sort(hcmp)
  result = handOrdered


#**********************************************************
#  valueAndSortHand:  Assigns hand highest possible       *
#                     numeric value based on max hand     *
#                     strength. Sorts hand semantically,  *
#                     with each component listed in       *
#                     descending order of valuation.      *
#**********************************************************
proc valueAndSortHand(handOrdered = orderHand(),
                      numInSuit = readCards().numInSuit,
                      royal = analyzeHand().royal,
                      straightFlush = analyzeHand().straightFlush,
                      flush = analyzeHand().flush,
                      straight = analyzeHand().straight,
                      wheel = analyzeHand().wheel,
                      four = analyzeHand().four,
                      three = analyzeHand().three,
                      trips = analyzeHand().trips,
                      pairs = analyzeHand().pairs): tuple[handValued: int64,
                                                          handSorted: seq[seq[int]]] =
  var
    matchTwo, matchThree, matchFour, matchStraight,
      matchSuit, matchFlush, handRemaining, handSorted = newSeq[seq[int]](0)
    handValued: int64

  handRemaining = handOrdered

  if royal:
    for i in 0 .. <SUITS:
      if numInSuit[i] >= 5:
        matchSuit.add handRemaining.filter do (x: seq[int]) -> bool:
          x[1] == i
    matchFlush.insert matchSuit.reversed[0]
    matchFlush.insert matchSuit.reversed[1]
    matchFlush.insert matchSuit.reversed[2]
    matchFlush.insert matchSuit.reversed[3]
    matchFlush.insert matchSuit.reversed[4]
    for i in 0 .. <matchFlush.len:
      for k,v in handRemaining:
        if v == matchFlush[i]:
          handRemaining.delete(k, k)
    for i in 0 .. <matchFlush.high - 3:
      if (matchFlush.reversed[i][0] - 1 == matchFlush.reversed[i + 1][0] and
          matchFlush.reversed[i][0] - 2 == matchFlush.reversed[i + 2][0] and
          matchFlush.reversed[i][0] - 3 == matchFlush.reversed[i + 3][0] and
          matchFlush.reversed[i][0] - 4 == matchFlush.reversed[i + 4][0]):
        matchStraight.insert matchFlush.reversed[i]
        matchStraight.insert matchFlush.reversed[i + 1]
        matchStraight.insert matchFlush.reversed[i + 2]
        matchStraight.insert matchFlush.reversed[i + 3]
        matchStraight.insert matchFlush.reversed[i + 4]
        break
    handValued = 1_000_000_000_000
    handSorted.add matchStraight
  elif wheel and straightFlush:
    for i in 0 .. <SUITS:
      if numInSuit[i] >= 5:
        matchSuit.add handRemaining.filter do (x: seq[int]) -> bool:
          x[1] == i
    matchFlush.add matchSuit[matchSuit.high]
    matchFlush.add matchSuit[0]
    matchFlush.add matchSuit[1]
    matchFlush.add matchSuit[2]
    matchFlush.add matchSuit[3]
    for i in 0 .. <matchFlush.len:
      for k,v in handRemaining:
        if v == matchFlush[i]:
          handRemaining.delete(k, k)
    matchStraight.add matchFlush[0]
    matchStraight.add matchFlush[1]
    matchStraight.add matchFlush[2]
    matchStraight.add matchFlush[3]
    matchStraight.add matchFlush[4]
    handValued = 900_000_000_000
    handValued += matchStraight[matchStraight.high][0]
    handSorted.add matchStraight
  elif straightFlush:
    for i in 0 .. <SUITS:
      if numInSuit[i] >= 5:
        matchSuit.add handRemaining.filter do (x: seq[int]) -> bool:
          x[1] == i
    for i in 0 .. <matchSuit.high - 3:
      if (matchSuit.reversed[i][0] - 1 == matchSuit.reversed[i + 1][0] and
          matchSuit.reversed[i][0] - 2 == matchSuit.reversed[i + 2][0] and
          matchSuit.reversed[i][0] - 3 == matchSuit.reversed[i + 3][0] and
          matchSuit.reversed[i][0] - 4 == matchSuit.reversed[i + 4][0]):
        matchStraight.insert matchSuit.reversed[i]
        matchStraight.insert matchSuit.reversed[i + 1]
        matchStraight.insert matchSuit.reversed[i + 2]
        matchStraight.insert matchSuit.reversed[i + 3]
        matchStraight.insert matchSuit.reversed[i + 4]
        break
    for i in 0 .. <matchStraight.len:
      for k,v in handRemaining:
        if v == matchStraight[i]:
          handRemaining.delete(k, k)
    handValued = 900_000_000_000
    handValued += matchStraight[matchStraight.high][0]
    handSorted.add matchStraight
  elif four:
    for i in 0 .. <handOrdered.reversed.high - 2:
      if handOrdered.reversed[i][0] == handOrdered.reversed[i + 3][0]:
        matchFour.add handOrdered.reversed.filter do (x: seq[int]) -> bool:
          x[0] == handOrdered.reversed[i][0]
        break
    for i in 0 .. <matchFour.len:
      for k,v in handRemaining:
        if v == matchFour[i]:
          handRemaining.delete(k, k)
    handValued = 800_000_000_000
    handValued += matchFour[matchFour.high][0]
    handSorted.add matchFour
    if handRemaining.len >= 1: handSorted.add handRemaining[handRemaining.high]
  elif (three and pairs >= 1) or (three and trips > 1):
    for i in 0 .. <handOrdered.reversed.high - 1:
      if handOrdered.reversed[i][0] == handOrdered.reversed[i + 2][0]:
        matchThree.add handOrdered.reversed.filter do (x: seq[int]) -> bool:
          x[0] == handOrdered.reversed[i][0]
        break
    for i in 0 .. <matchThree.len:
      for k,v in handRemaining:
        if v == matchThree[i]:
          handRemaining.delete(k, k)
    for i in 0 .. <handRemaining.reversed.high:
      if handRemaining.reversed[i][0] == handRemaining.reversed[i + 1][0]:
        matchTwo.add handRemaining.reversed.filter do (x: seq[int]) -> bool:
          x[0] == handRemaining.reversed[i][0]
        if matchTwo.len > 2: matchTwo.delete(matchTwo.high, matchTwo.high)
        break
    for i in 0 .. <matchTwo.len:
      for k,v in handRemaining:
        if v == matchTwo[i]:
          handRemaining.delete(k, k)
    handValued = 700_000_000_000
    handValued += (matchThree[matchThree.high][0] * 10^2)
    handValued += matchTwo[matchTwo.high][0]
    handSorted.add matchThree
    handSorted.add matchTwo
  elif flush:
    for i in 0 .. <SUITS:
      if numInSuit[i] >= 5:
        matchSuit.add handRemaining.filter do (x: seq[int]) -> bool:
          x[1] == i
    matchFlush.add matchSuit.reversed[0]
    matchFlush.add matchSuit.reversed[1]
    matchFlush.add matchSuit.reversed[2]
    matchFlush.add matchSuit.reversed[3]
    matchFlush.add matchSuit.reversed[4]
    for i in 0 .. <matchFlush.len:
      for k,v in handRemaining:
        if v == matchFlush[i]:
          handRemaining.delete(k, k)
    handValued = 600_000_000_000
    handValued += (matchFlush[matchFlush.low][0] * 10^8)
    handValued += (matchFlush[matchFlush.low + 1][0] * 10^6)
    handValued += (matchFlush[matchFlush.low + 2][0] * 10^4)
    handValued += (matchFlush[matchFlush.low + 3][0] * 10^2)
    handValued += matchFlush[matchFlush.low + 4][0]
    handSorted.add matchFlush
  elif wheel:
    matchStraight.add handOrdered.dedup[handOrdered.dedup.high]
    matchStraight.add handOrdered.dedup[0]
    matchStraight.add handOrdered.dedup[1]
    matchStraight.add handOrdered.dedup[2]
    matchStraight.add handOrdered.dedup[3]
    handValued = 500_000_000_000
    handValued += matchStraight[matchStraight.high][0]
    handSorted.add matchStraight
  elif straight:
    for i in 0 .. <handOrdered.dedup.high - 3:
      if (handOrdered.dedup.reversed[i][0] - 1 == handOrdered.dedup.reversed[i + 1][0] and
          handOrdered.dedup.reversed[i][0] - 2 == handOrdered.dedup.reversed[i + 2][0] and
          handOrdered.dedup.reversed[i][0] - 3 == handOrdered.dedup.reversed[i + 3][0] and
          handOrdered.dedup.reversed[i][0] - 4 == handOrdered.dedup.reversed[i + 4][0]):
        matchStraight.insert handOrdered.dedup.reversed[i]
        matchStraight.insert handOrdered.dedup.reversed[i + 1]
        matchStraight.insert handOrdered.dedup.reversed[i + 2]
        matchStraight.insert handOrdered.dedup.reversed[i + 3]
        matchStraight.insert handOrdered.dedup.reversed[i + 4]
        break
    for i in 0 .. <matchStraight.len:
      for k,v in handRemaining:
        if v == matchStraight[i]:
          handRemaining.delete(k, k)
    handValued = 500_000_000_000
    handValued += matchStraight[matchStraight.high][0]
    handSorted.add matchStraight
  elif three:
    for i in 0 .. <handOrdered.high - 1:
      if handOrdered[i][0] == handOrdered[i + 2][0]:
        matchThree.add handOrdered.filter do (x: seq[int]) -> bool:
          x[0] == handOrdered[i][0]
    for i in 0 .. <matchThree.len:
      for k,v in handRemaining:
        if v == matchThree[i]:
          handRemaining.delete(k, k)
    handValued = 400_000_000_000
    handValued += (matchThree[matchThree.high][0] * 10^4)
    handSorted.add matchThree
    if handRemaining.len >= 2:
      handValued += (handRemaining[handRemaining.high][0] * 10^2)
      handValued += handRemaining[handRemaining.high - 1][0]
      handSorted.add handRemaining[handRemaining.high]
      handSorted.add handRemaining[handRemaining.high - 1]
    elif handRemaining.len == 1:
      handValued += handRemaining[handRemaining.high][0]
      handSorted.add handRemaining[handRemaining.high]
  elif pairs >= 1:
    var matches = 0
    for i in 0 .. <handOrdered.reversed.high:
      if matches < 3:
        if handOrdered.reversed[i][0] == handOrdered.reversed[i + 1][0]:
          matchTwo.insert handOrdered.reversed.filter do (x: seq[int]) -> bool:
            x[0] == handOrdered.reversed[i][0]
          inc matches
      else: break
    for i in 0 .. <matchTwo.len:
      for k,v in handRemaining:
        if v == matchTwo[i]:
          handRemaining.delete(k, k)
    let d2 = (matchTwo.len / 2).toInt
    if pairs > 1:
      handValued = 300_000_000_000
      handValued += (matchTwo.distribute(d2)[matchTwo.distribute(d2).high][0][0] * 10^4)
      handValued += (matchTwo.distribute(d2)[matchTwo.distribute(d2).high - 1][0][0] * 10^2)
      if handRemaining.len > 0: handValued += handRemaining[handRemaining.high][0]
      handSorted.add matchTwo.distribute(d2)[matchTwo.distribute(d2).high]
      handSorted.add matchTwo.distribute(d2)[matchTwo.distribute(d2).high - 1]
      if handRemaining.len > 0: handSorted.add handRemaining[handRemaining.high]
    elif pairs == 1:
      handValued = 200_000_000_000
      handValued += (matchTwo.distribute(d2)[matchTwo.distribute(d2).high][0][0] * 10^6)
      handSorted.add matchTwo.distribute(d2)[matchTwo.distribute(d2).high]
      var matches = 0
      for i in 0 .. handRemaining.reversed.len:
        if matches < 3:
          handValued += (handRemaining.reversed[i][0] * 10^(4 - (matches * 2)))
          handSorted.add handRemaining.reversed[i]
          inc matches
  else:
    var matches = 0
    for i in 0 .. handRemaining.reversed.len:
      if matches < 5:
        handValued += (handRemaining.reversed[i][0] * 10^(8 - (matches * 2)))
        handSorted.add handRemaining.reversed[i]
        inc matches

  (handValued, handSorted)


#**********************************************************
#  printResult:  Prints the classification of the hand,   *
#                based on the values of the external      *
#                variables royal, flush, straight, wheel, *
#                four, three, and pairs.                  *
#**********************************************************
proc printResult(handSorted = valueAndSortHand().handSorted,
                 handValued = valueAndSortHand().handValued,
                 royal = analyzeHand().royal,
                 straightFlush = analyzeHand().straightFlush,
                 flush = analyzeHand().flush,
                 straight = analyzeHand().straight,
                 wheel = analyzeHand().wheel,
                 four = analyzeHand().four,
                 three = analyzeHand().three,
                 trips = analyzeHand().trips,
                 pairs = analyzeHand().pairs) =
  var
    displayRank, displaySuit, displayCard: string
    displayHand = newSeq[string](0)

  for i in 0 .. <handSorted.len:
    case handSorted[i][0]
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
    case handSorted[i][1]
    of 0: displaySuit = "c"
    of 1: displaySuit = "d"
    of 2: displaySuit = "h"
    of 3: displaySuit = "s"
    else: discard
    displayCard = displayRank & displaySuit
    displayHand.add displayCard

  proc printClassification() =
    if royal:
      echo "Royal Flush of ",
        case handSorted[0][1]
        of 0: "Clubs"
        of 1: "Diamonds"
        of 2: "Hearts"
        of 3: "Spades"
        else: ""
    elif straightFlush:
      echo "Straight flush of ",
        case handSorted[0][1]
        of 0: "clubs"
        of 1: "diamonds"
        of 2: "hearts"
        of 3: "spades"
        else: "",
        ", ",
        case handSorted[handSorted.low][0]
        of 0: "two"
        of 1: "three"
        of 2: "four"
        of 3: "five"
        of 4: "six"
        of 5: "seven"
        of 6: "eight"
        of 7: "nine"
        of 8: "ten"
        of 9: "Jack"
        of 10: "Queen"
        of 11: "King"
        of 12: "Ace"
        else: "",
        " to ",
        case handSorted[handSorted.high][0]
        of 0: "two"
        of 1: "three"
        of 2: "four"
        of 3: "five"
        of 4: "six"
        of 5: "seven"
        of 6: "eight"
        of 7: "nine"
        of 8: "ten"
        of 9: "Jack"
        of 10: "Queen"
        of 11: "King"
        of 12: "Ace"
        else: ""
    elif four:
      echo "Four of a kind, ",
        case handSorted[0][0]
        of 0: "deuces"
        of 1: "threes"
        of 2: "fours"
        of 3: "fives"
        of 4: "sixes"
        of 5: "sevens"
        of 6: "eights"
        of 7: "nines"
        of 8: "tens"
        of 9: "Jacks"
        of 10: "Queens"
        of 11: "Kings"
        of 12: "Aces"
        else: ""
    elif (three and pairs >= 1) or (three and trips > 1):
      echo "Full house, ",
        case handSorted[handSorted.low][0]
        of 0: "deuces"
        of 1: "threes"
        of 2: "fours"
        of 3: "fives"
        of 4: "sixes"
        of 5: "sevens"
        of 6: "eights"
        of 7: "nines"
        of 8: "tens"
        of 9: "Jacks"
        of 10: "Queens"
        of 11: "Kings"
        of 12: "Aces"
        else: "",
        " over ",
        case handSorted[handSorted.high][0]
        of 0: "deuces"
        of 1: "threes"
        of 2: "fours"
        of 3: "fives"
        of 4: "sixes"
        of 5: "sevens"
        of 6: "eights"
        of 7: "nines"
        of 8: "tens"
        of 9: "Jacks"
        of 10: "Queens"
        of 11: "Kings"
        of 12: "Aces"
        else: ""
    elif flush:
      echo "Flush of ",
        case handSorted[0][1]
        of 0: "clubs"
        of 1: "diamonds"
        of 2: "hearts"
        of 3: "spades"
        else: "",
        ", ",
        case handSorted[handSorted.low][0]
        of 0: "two"
        of 1: "three"
        of 2: "four"
        of 3: "five"
        of 4: "six"
        of 5: "seven"
        of 6: "eight"
        of 7: "nine"
        of 8: "ten"
        of 9: "Jack"
        of 10: "Queen"
        of 11: "King"
        of 12: "Ace"
        else: "",
        " high"
    elif straight:
      echo "Straight, ",
        case handSorted[handSorted.low][0]
        of 0: "two"
        of 1: "three"
        of 2: "four"
        of 3: "five"
        of 4: "six"
        of 5: "seven"
        of 6: "eight"
        of 7: "nine"
        of 8: "ten"
        of 9: "Jack"
        of 10: "Queen"
        of 11: "King"
        of 12: "Ace"
        else: "",
        " to ",
        case handSorted[handSorted.high][0]
        of 0: "two"
        of 1: "three"
        of 2: "four"
        of 3: "five"
        of 4: "six"
        of 5: "seven"
        of 6: "eight"
        of 7: "nine"
        of 8: "ten"
        of 9: "Jack"
        of 10: "Queen"
        of 11: "King"
        of 12: "Ace"
        else: ""
    elif three:
      echo "Three of a kind, ",
        case handSorted[0][0]
        of 0: "deuces"
        of 1: "threes"
        of 2: "fours"
        of 3: "fives"
        of 4: "sixes"
        of 5: "sevens"
        of 6: "eights"
        of 7: "nines"
        of 8: "tens"
        of 9: "Jacks"
        of 10: "Queens"
        of 11: "Kings"
        of 12: "Aces"
        else: ""
    elif pairs >= 2:
      echo "Two pair, ",
        case handSorted[handSorted.low][0]
        of 0: "deuces"
        of 1: "threes"
        of 2: "fours"
        of 3: "fives"
        of 4: "sixes"
        of 5: "sevens"
        of 6: "eights"
        of 7: "nines"
        of 8: "tens"
        of 9: "Jacks"
        of 10: "Queens"
        of 11: "Kings"
        of 12: "Aces"
        else: "",
        " and ",
        case handSorted[handSorted.high - 1][0]
        of 0: "deuces"
        of 1: "threes"
        of 2: "fours"
        of 3: "fives"
        of 4: "sixes"
        of 5: "sevens"
        of 6: "eights"
        of 7: "nines"
        of 8: "tens"
        of 9: "Jacks"
        of 10: "Queens"
        of 11: "Kings"
        of 12: "Aces"
        else: ""
    elif pairs == 1:
      echo "A pair of ",
        case handSorted[handSorted.low][0]
        of 0: "deuces"
        of 1: "threes"
        of 2: "fours"
        of 3: "fives"
        of 4: "sixes"
        of 5: "sevens"
        of 6: "eights"
        of 7: "nines"
        of 8: "tens"
        of 9: "Jacks"
        of 10: "Queens"
        of 11: "Kings"
        of 12: "Aces"
        else: ""
    else:
      echo "High card ",
        case handSorted[handSorted.low][0]
        of 0: "two"
        of 1: "three"
        of 2: "four"
        of 3: "five"
        of 4: "six"
        of 5: "seven"
        of 6: "eight"
        of 7: "nine"
        of 8: "ten"
        of 9: "Jack"
        of 10: "Queen"
        of 11: "King"
        of 12: "Ace"
        else: ""

  proc printHand() =
    stdout.write "["
    for i in 0 .. <displayHand.len:
      stdout.write displayHand[i]
      if i < displayHand.len - 1: stdout.write ", "
    echo "]"

  proc printValue() =
    echo "Hand value: ", handValued

  printClassification()
  printHand()
  printValue()


#**********************************************************
#  main: Calls readCards, analyzeHand and printResult     *
#        repeatedly.                                      *
#**********************************************************
proc main() =
  printResult()


main()
