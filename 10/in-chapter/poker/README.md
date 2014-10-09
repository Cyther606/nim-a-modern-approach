poker
=====

Usage
-----

    ./poker $(./deal 5)


To build
---------

#### Dependencies

- Nim
- Patience

#### Compile

    nim c deal.nim
    nim c poker.nim


Known Bugs
----------

- 1 card, 2 card, 3 card and 4 card hands crash the program with a runtime error
  - if-elif-else block in valueAndSortHand proc is to blame, likely
    because the if blocks are being evaluated, and for hands of less
    than 5 in length, the subtraction and addition clauses produce value
    outside range of seq
  - Tried converting the valueAndSortHand proc into a template to
    avoid evaluating unneeded if-blocks, but got a lamda lifting bug
  - Tried converting the if-elif-else block due when-elif-else block,
    but fails because when only works with values known at compile-time
- Larger hands (24-52), often crash the program in the print and classify
  hand proc
- Need to add +1 to all handRemaining values, because otherwise a 2 in
  hand counts for 0, and therefore a four-handed hand AAAK == AAAK2


Showdown
--------

    Royal Flush of [C|D|H|S]
      "Royal Flush of Spades"
    Straight flush of [C|D|H|S], [X] to [Y]
      "Straight flush of clubs, six to ten"
    Four of a kind, [X]s
      "Four of a kind, fives"
    Full house, [X]s over [Y]s
      "Full house, Aces over sixes"
    Flush, [X] high, [Y] kicker
      "Flush, Ace high - Queen kicker"
    Straight, [X] to [Y]
      "Straight, ten to Ace"
    Three of a kind, [X]s, [Y] kicker
      "Three of a kind, Queens - King kicker"
    Two pair, [X]s and [Y]s, [Z] kicker
      "Two pair, Jacks and tens - Ace kicker"
    Pair of [X]s, [Y] kicker
      "Pair of Kings - Ace kicker"
    High card [X], [Y] kicker
      "High card Ace - King kicker"

#### Strategies for announcing kicker cards

Only echo kicker card if it's the deciding factor in who wins the
hand.

    Player1 shows Three of a kind, fives - Ace kicker
    Player2 shows Three of a kind, fives - King kicker

    Player 2 mucks
    Player 1 wins the pot

Or, only echo the kicker card after the winner's hand is shown.

    Player1 shows Three of a kind, fives
    Player2 shows Three of a kind, fives

    Player 1 shows Ace kicker
    Player 2 mucks

    Player 1 wins the pot

#### Hole cards

Need to track hole cards throughout hand, so that the hole card is shown
in displayHand if at all possible.

    Sara cards: [Kd, Qh]
    Bill cards: [Ks, Qc]

    board: [Kh, As, 3s, 4d, 7s]

    Sara shows: [Kh, Kd, As, Qh, 7s]
    Bill shows: [Kh, Ks, As, Qc, 7s]


Code snippets
-------------

```nim
# check for straights

var counter, numConsec = 0
for i in 0 .. <numInRank.len:
  if i == numInRank.high:
    if numInRank[i] > 0:
      if numInRank[i - 1] > 0:
        inc counter
        numConsec = counter
      else:
        counter = 0
  else:
    if numInRank[i] > 0:
      if numInRank[i + 1] > 0:
        inc counter
      else:
        if (counter + 1) > numConsec: numConsec = counter + 1
        counter = 0
if numConsec >= 5:
  straight = true
elif numInRank[RANKS - 1] > 0 and
  numInRank[0] > 0 and
  numInRank[1] > 0 and
  numInRank[2] > 0 and
  numInRank[3] > 0:
  straight = true
  wheel = true
```
