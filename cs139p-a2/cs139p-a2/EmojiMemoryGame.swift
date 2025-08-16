//
//  EmojiMemoryGame.swift
//  cs139p-a2
//
//  Created by Cynthia Lim on 2025-08-12.
//

// view model

import SwiftUI


var listOfThemes = [
  Theme(name: "plants", emojis: ["🌵", "🌲", "🪴", "🌴", "🌳", "🌿"], numPairs: 4, color: "green"),
  Theme(name: "animals", emojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵", "🐔", "🐧", "🐦", "🐤", "🐣", "🦆", "🦅", "🦉"], numPairs: 14, color: "black"),
  Theme(name: "faces", emojis: ["😀", "😃", "😄", "😁", "😆", "🥹", "😊", "🙂", "😉", "😍", "🥰", "😘", "😚", "😋", "😝"], numPairs: 5, color: "orange"),
  Theme(name: "sports", emojis: ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🏐"], numPairs: 3, color: "blue"),
  Theme(name: "foods", emojis: ["🍎", "🍌", "🍓", "🍇", "🍊", "🍉", "🍒", "🥭", "🍍", "🥝", "🍑", "🥥", "🥦", "🥕", "🌽", "🍔", "🍟", "🍕", "🌮", "🍣"], numPairs: 12, color: "purple"),
  Theme(name: "weather", emojis: ["☀️", "🌤️", "⛅", "🌧️", "⛈️", "🌩️", "❄️", "🌬️", "🌪️", "🌈", "🌙", "⭐", "🌌", "🌍", "🌎", "🌏", "🪐", "☄️", "🌠", "🌞"], numPairs: 10, color: "yellow")
]

class EmojiMemoryGame: ObservableObject {
  
  private(set) var theme: Theme
  @Published private var model: MemoryGame<String>
  
  init () {
    theme = listOfThemes.randomElement() ?? listOfThemes[1]
    model = EmojiMemoryGame.createMemoryGame(theme)
  }
  
  private static func createMemoryGame(_ theme: Theme) -> MemoryGame<String> {
    var themeEmojis = theme.emojis
    if theme.numPairs < theme.emojis.count {
      // shuffle so that you don't always get the same emojis from the same theme
      themeEmojis = theme.emojis.shuffled()
    }
      return MemoryGame(numPairs: theme.numPairs) { pairIndex in
        if themeEmojis.indices.contains(pairIndex) {
          return themeEmojis[pairIndex]
        }
        else {
          return "??"
        }
    }
  }
  

  var cards: Array<MemoryGame<String>.Card> {
    return model.cards
  }
  
  var cardColor: Color {
    switch theme.color {
    case "blue":
      return Color.blue
    case "green":
      return .green
    case "purple":
      return .purple
    case "orange":
      return .orange
    case "black":
      return .black
    case "yellow":
      return .yellow
    default:
      return .pink
    }
  }
  
  var score: Int { return model.score}
  
  
  // MARK: Intents
  
  func shuffle () {
    return model.shuffle()
  }
  
  func choose (_ card: MemoryGame<String>.Card) {
    return model.choose(card)
  }
  
  func reset() {
    return model.reset()
  }
  
  func changeTheme() {
    theme = listOfThemes.randomElement() ?? listOfThemes[1]
    model = EmojiMemoryGame.createMemoryGame(theme)
  }
}
