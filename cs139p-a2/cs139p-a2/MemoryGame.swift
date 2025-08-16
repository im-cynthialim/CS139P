//
//  MemoryGame.swift
//  cs139p-a2
//
//  Created by Cynthia Lim on 2025-08-12.
//

import Foundation

struct Theme {
  let name: String
  var emojis: [String]
  let numPairs: Int
  let color: String
}


// model
struct MemoryGame<CardContent> where CardContent: Equatable {
  private(set) var cards: Array<Card>
  private(set) var score: Int
  
  init (numPairs: Int, makeCardContent: (Int) -> CardContent) {
  
    cards = []
    for pairIndex in 0..<max(2, numPairs) {
      let content = makeCardContent(pairIndex)
      cards.append(Card(content: content, id: "\(pairIndex+1)a"))
      cards.append(Card(content: content, id: "\(pairIndex+1)b"))
    }
    cards.shuffle()
    score = 0
  }
  
  mutating func shuffle() {
    cards.shuffle()
  }
  
  mutating func reset() {
    score = 0
    // cannot change values directly with forEach - this gives a copy
    // instead, mutate using array indices
    cards.indices.forEach {
      cards[$0].isFaceUp = false
      cards[$0].isMatched = false
      cards[$0].hasBeenFlipped = false
    }
  }
  
  var indexOfTheOneAndOnlyFaceUpCard: Int? {
    get {
      let faceUpCardIndices = cards.indices.filter { index in cards[index].isFaceUp}
      return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
    }
    set {
      cards.indices.forEach {
        cards[$0].isFaceUp = (newValue == $0)
      }
    }
  }
  
  mutating func choose(_ card: Card) {
    if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}) {
      if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
        // compares chosen card to the one that is already face up
        if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
          if cards[chosenIndex].content == cards[potentialMatchIndex].content {
            // if cards match, give 2 points
            cards[chosenIndex].isMatched = true
            cards[potentialMatchIndex].isMatched = true
            score += 2
          }
          else {
            // cards don't match, check if they've been flipped before
            if cards[chosenIndex].hasBeenFlipped && !cards[chosenIndex].isMatched {
              score -= 1
            }
            if cards[potentialMatchIndex].hasBeenFlipped && !cards[potentialMatchIndex].isMatched {
              score -= 1
            }
            cards[potentialMatchIndex].hasBeenFlipped = true
            cards[chosenIndex].hasBeenFlipped = true
          }
          
        }
        else {
          indexOfTheOneAndOnlyFaceUpCard = chosenIndex
        }
      }
      cards[chosenIndex].isFaceUp = true
    }
  }
  
  struct Card: Equatable, Identifiable {
    var isFaceUp: Bool = false
    var isMatched: Bool = false
    var hasBeenFlipped: Bool = false
    let content: CardContent
    var id: String
  }
}

