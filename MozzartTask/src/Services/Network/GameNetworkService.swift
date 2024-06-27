//
//  GameNetworkService.swift
//  MozzartTask
//
//  Created by Mihail Tiranov on 24.6.24.
//

import Foundation

class GameNetworkService: NetworkService {
  
  // MARK: - Public (Interface)
  func loadResults(fromDate: Date, toDate: Date) async throws -> [Game] {
    do {
      return try await localDecoder
        .decode(
          [Game].self,
          from: try sendRequest(for: .loadResults(fromDate: fromDate, toDate: toDate))
        )
    } catch {
      throw RequestError.wrongModel
    }
  }
  
  func loadRounds() async throws -> [Game] {
    do {
      return try await localDecoder
        .decode(
          [Game].self,
          from: try sendRequest(for: .loadRounds())
        )
    } catch {
      throw RequestError.wrongModel
    }
  }
  
  func loadGame(for drawID: String) async throws -> Game {
    do {
      return try await localDecoder
        .decode(
          Game.self,
          from: try sendRequest(for: .loadGame(drawID: drawID))
        )
    } catch {
      throw RequestError.wrongModel
    }
  }
}
