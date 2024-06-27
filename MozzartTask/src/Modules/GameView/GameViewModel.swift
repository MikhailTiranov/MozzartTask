//
//  GameViewModel.swift
//  MozzartTask
//
//  Created by Mihail Tiranov on 25.6.24.
//

import SwiftUI
import Combine

final class GameViewModel: ObservableObject {
  
  // MARK: - Public (Properties)
  let game: Game
  @Published var current = Date().timeIntervalSince1970
  
  var chosenNumbersCount: Int { chosenNumbers.count }
  
  @Published var isBetMade = false
  
  var isBetButtonDisabled: Bool {
    chosenNumbersCount == 0 || isBetMade
  }
  
  // MARK: - Private (Properties)
  private let gameService: GameNetworkService
  
  @Published private var chosenNumbers: Set<Int> = []
  
  // MARK: - Init
  init(
    game: Game,
    gameService: GameNetworkService
  ) {
    self.gameService = gameService
    self.game = game
    updateBets()
  }
  
  // MARK: - Public (Interface)
  func handleTapOnNumber(_ value: Int) {
    if chosenNumbers.contains(value) {
      chosenNumbers.remove(value)
    } else {
      if chosenNumbers.count < 15 {
        chosenNumbers.insert(value)
      }
    }
  }
  
  func makeBet() {
    if !isBetMade && game.drawTime > Date() {
      isBetMade = true
      Storage.shared.saveBet(for: game.drawID, numbers: chosenNumbers)
    } else if game.drawTime > Date() {
      isBetMade = true
    }
  }
  
  func isNumberChosen(_ value: Int) -> Bool {
    chosenNumbers.contains(value)
  }
  
  // MARK: - Private (Interface)
  private func updateBets() {
    guard let bets = Storage.shared.loadBets()[game.drawID] else { return }
    isBetMade = true
    chosenNumbers = bets
  }
}
