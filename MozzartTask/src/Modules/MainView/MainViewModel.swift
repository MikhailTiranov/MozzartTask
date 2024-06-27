//
//  MainViewModel.swift
//  MozzartTask
//
//  Created by Mihail Tiranov on 24.6.24.
//

import Foundation
import Combine

@MainActor
final class MainViewModel: ObservableObject {
  
  // MARK: - Public (Properties)
  let gameService: GameNetworkService
  
  @Published var games: [Game] = []
  @Published var current = Date().timeIntervalSince1970
  
  @Published var isError: Bool = false
  var errorMessage = ""
  
  // MARK: - Private (Properties)
  private var cancellables = Set<AnyCancellable>()
  private var updateTime: Double?
  
  private let timer = Timer
    .publish(every: 1, on: .main, in: .common)
    .autoconnect()
  
  private var isDownloading = false
  
  // MARK: - Init
  init(gameService: GameNetworkService) {
    self.gameService = gameService
    loadGames()
    updateTimers()
  }
  
  // MARK: - Public (Interface)
  func loadGames() {
    if !isDownloading {
      Task {
        do {
          isDownloading = true
          games = try await gameService.loadRounds()
          isDownloading = false
        } catch let error {
          errorMessage =
          (error as? RequestError)?.description
          ?? error.localizedDescription
          isError = true
          isDownloading = false
        }
      }
    }
  }
  
  func updateTimers() {
    let cancellable = timer.sink { [weak self] _ in
      guard let self else { return }
      
      self.current = Date().timeIntervalSince1970
      
      if let firstDrawTime = games.first?.drawTime {
        self.updateTime = (firstDrawTime - current).timeIntervalSince1970
      }
      
      if
        let updateTime = self.updateTime,
        updateTime <= .zero
      {
        self.loadGames()
      }
    }
    cancellable.store(in: &cancellables)
  }
}
