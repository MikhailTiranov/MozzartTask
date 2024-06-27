//
//  MozzartTaskApp.swift
//  MozzartTask
//
//  Created by Mihail Tiranov on 24.6.24.
//

import SwiftUI

@main
struct MozzartTaskApp: App {
  
  // MARK: - App
  var body: some Scene {
    WindowGroup {
      MainView(
        viewModel: MainViewModel(
          gameService: GameNetworkService()
        )
      )
    }
  }
}
