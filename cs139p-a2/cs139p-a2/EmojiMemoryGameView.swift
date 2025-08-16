//
//  EmojiMemoryGameView.swift
//  cs139p-a2
//
//  Created by Cynthia Lim on 2025-08-12.
//

import SwiftUI

// view
struct EmojiMemoryGameView: View {
  @ObservedObject var viewModel: EmojiMemoryGame
  
  var body: some View {
    VStack {
      HStack {
        Text(viewModel.theme.name).font(.largeTitle)
        Spacer()
        Text("Score: \(viewModel.score)")
      }
      ScrollView {
        cards
          .animation(.default, value: viewModel.cards)
      }
      Button ("Shuffle") {
        viewModel.shuffle()
      }
      Button ("New Game") {
        viewModel.reset()
        viewModel.shuffle()
      }
      Button ("Change Theme") {
        viewModel.changeTheme()
      }
    }
    .padding()
  }
  var cards: some View {
    LazyVGrid (columns: [GridItem(.adaptive(minimum: 80), spacing: 0)], spacing: 0) {
      
      ForEach (viewModel.cards) { card in
        CardView(card)
          .aspectRatio(2/3, contentMode: .fit)
          .padding(4)
          .foregroundStyle(viewModel.cardColor)
          .onTapGesture {
            viewModel.choose(card)
          }
      }
    }
    .foregroundStyle(.blue)
  }
  
}

struct CardView: View {
  let card: MemoryGame<String>.Card
  
  init(_ card: MemoryGame<String>.Card) {
    self.card = card
  }
  
  var body: some View {
    ZStack {
      let base =  RoundedRectangle(cornerRadius: 10)
      Group {
        base.strokeBorder(lineWidth: 2)
        Text(card.content)
          .font(.system(size: 200))
          .minimumScaleFactor(0.01)
          .aspectRatio(1, contentMode: .fit)
      }
      .font(.system(size: 30))
      .opacity (card.isFaceUp ? 1 : 0)
      base.fill().opacity(card.isFaceUp ? 0 : 1)
    }
    .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
  }
}

#Preview {
  EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}

