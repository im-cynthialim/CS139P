//
//  cs139p_a2App.swift
//  cs139p-a2
//
//  Created by Cynthia Lim on 2025-08-12.
//

import SwiftUI

@main
struct cs139p_a2App: App {
  @StateObject var game = EmojiMemoryGame()
  
    var body: some Scene {
        WindowGroup {
          EmojiMemoryGameView(viewModel: game)
        }
    }
}
