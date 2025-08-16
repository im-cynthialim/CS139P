//
//  ContentView.swift
//  cs139p-a1
//
//  Created by Cynthia Lim on 2025-07-26.
//

import SwiftUI

func createEmojiPairs (emojiSet: [String]) -> [String] {
  // create pair
  var pairs = emojiSet + emojiSet
  pairs.shuffle()
  return pairs
}

struct ContentView: View {
  @State var emojis: [String] = createEmojiPairs(emojiSet: ["😀", "😅", "😌", "😁", "😃", "😄"])
  
  var body: some View {
    VStack {
      Text("Memorize!")
        .font(.largeTitle)
      ScrollView {
        cards
        
      }
      HStack {
        themeButton(emojiSet: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊"], image: "pawprint.circle", labelText: "Animals"
        )
        
        Spacer()
        
        themeButton(emojiSet: ["🌵", "🌲", "🪴", "🌴", "🌳", "🌿"], image: "tree.circle", labelText: "Plants")
        
        Spacer()
        
        themeButton(emojiSet:  ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🏐"], image: "sportscourt.circle", labelText: "Sports")
        
        
      }
    }
    .padding()
  }
  var cards: some View {
    LazyVGrid (columns: [GridItem(.adaptive(minimum: 80))]) {
      
      ForEach (emojis.indices, id: \.self) {
        index in
        CardView(text: emojis[index])
          .aspectRatio(2/3, contentMode: .fit)
      }
    }
    .foregroundStyle(.blue)
  }
  
  func themeButton(emojiSet: [String], image: String, labelText: String) ->  some View {
    Button (action: {
      emojis = createEmojiPairs(emojiSet: emojiSet)
    }, label: {
      VStack {
        Image(systemName: image)
        Text(labelText)
      }
    })
    
  }
}



struct CardView: View {
  var text: String
  @State var isFaceUp = false
  
  var body: some View {
    ZStack {
      let base =  RoundedRectangle(cornerRadius: 10)
      Group {
        base.fill(.white)
        base.strokeBorder(lineWidth: 2)
        Text(text)
      }
      .font(.system(size: 30))
      .opacity (isFaceUp ? 1 : 0)
      base.fill().opacity(isFaceUp ? 0 : 1)
    }
    .onTapGesture {
      isFaceUp.toggle()
    }
  }
}

#Preview {
  ContentView()
}
