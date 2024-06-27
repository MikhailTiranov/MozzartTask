//
//  GameNetworkService.swift
//  MozzartTask
//
//  Created by Mihail Tiranov on 24.6.24.
//

import Foundation

final class GameNetworkService: NetworkService {
  
  // MARK: - Public (Interface)
  func loadResults(fromDate: Date, toDate: Date) async throws -> [Game] {
    do {
      return try await localDecoder
        .decode(
          [Game].self,
          from: try sendRequest(for: .loadResults(fromDate: fromDate, toDate: toDate))
        )
    } catch let error {
      if error is DecodingError {
        throw RequestError.wrongModel
      } else {
        throw error
      }
    }
  }
  
  func loadRounds() async throws -> [Game] {
    do {
      return try await localDecoder
        .decode(
          [Game].self,
          from: try sendRequest(for: .loadRounds())
        )
    } catch let error {
      if error is DecodingError {
        throw RequestError.wrongModel
      } else {
        throw error
      }
    }
  }
  
  func loadGame(for drawID: String) async throws -> Game {
    do {
      return try await localDecoder
        .decode(
          Game.self,
          from: try sendRequest(for: .loadGame(drawID: drawID))
        )
    } catch let error {
      if error is DecodingError {
        throw RequestError.wrongModel
      } else {
        throw error
      }
    }
  }
}
