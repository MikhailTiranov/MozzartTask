//
//  ResultsViewModel.swift
//  MozzartTask
//
//  Created by Mihail Tiranov on 27.6.24..
//

import Foundation

class ResultsViewModel: ObservableObject {
  
  // MARK: - Public (Properties)
  var games: [Game] = []
  
  @Published var isLoading = true
  
  @Published var isError: Bool = false
  var errorMessage = ""

  // MARK: - Private (Properties)
  private let gameService: GameNetworkService
  private let playedGames = Storage.shared.loadBets()
  
  // MARK: - Init
  init(
    gameService: GameNetworkService
  ) {
    self.gameService = gameService
    loadGames()
  }
  
  // MARK: - Public (Interface)
  func loadGames() {
    let keys = playedGames.keys.sorted() as [Int]
    
    Task {
      do {
        for key in keys {
          let game = try await gameService.loadGame(for: String(key))
          if let index = games.firstIndex(where: { $0.drawID == game.drawID }) {
            games[index] = game
          } else {
            games.append(game)
          }
        }
        isLoading = false
      } catch let error {
        isLoading = false
        errorMessage =
        (error as? RequestError)?.description
        ?? error.localizedDescription
        isError = true
      }
    }
  }
  
  func receiveMatchesForGame(_ game: Game) -> Int {
    let results = Set(game.winningNumbers?.list ?? [])
    let playedResults = Set(playedGames[game.drawID] ?? [])
    
    let commonValues = results.intersection(playedResults)
    return commonValues.count
  }
}
