//
//  Game.swift
//  MozzartTask
//
//  Created by Mihail Tiranov on 24.6.24..
//

import Foundation

// MARK: - Game
struct Game: Codable {
  
  // MARK: - Public (Properties)
  let gameID: Int
  let drawID: Int
  let drawTime: Date
  let status: Status
  let winningNumbers: WinningNumbers?
  
  // MARK: - Codable
  enum CodingKeys: String, CodingKey {
    case gameID = "gameId"
    case drawID = "drawId"
    case drawTime
    case winningNumbers
    case status
  }
}

// MARK: - PrizeCategory
struct WinningNumbers: Codable {
  
  // MARK: - Public (Properties)
  let list: [Int]
}

// MARK: - Status
enum Status: String, Codable {
  case active
  case future
  case results
}

extension Game {
  static var mock: Game {
    Game(
      gameID: 1100,
      drawID: 838524,
      drawTime: Date(), 
      status: .active,
      winningNumbers: nil
    )
  }
}
