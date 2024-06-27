//
//  EndPoint.swift
//  MozzartTask
//
//  Created by Mikhail Tiranov on 24.6.24.
//

import Foundation

enum EndPoint {
  case loadResults(fromDate: Date, toDate: Date)
  case loadRounds(quantity: Int = 20)
  case loadGame(drawID: String)
}

extension EndPoint {
  
  // MARK: - Private (Properties)
  private var endPointPath: String {
    switch self {
    case let .loadResults(fromDate, toDate):
      "\(gameID)/\(fromDate)/\(toDate)"
    case let .loadRounds(quantity):
      "\(gameID)/upcoming/\(quantity)"
    case let .loadGame(drawID):
      "\(gameID)/\(drawID)"
    }
  }
  
  private var gameID: String { "1100" }
  
  private var commonPath: String { "/draws/v3.0/" }
}

// MARK: - RestEndPointType
extension EndPoint: RestEndPointType {
  
  var scheme: String { "https" }

  var host: String { "api.opap.gr" }
  
  var path: String { commonPath + endPointPath }
  
  var queryItems: [String: String]? { nil }
  
  var bodyParameters: [String: Any?]? { nil }
  
  var httpMethod: HTTPMethod { .get }
  
  var headers: [String: String]? { nil }
}
