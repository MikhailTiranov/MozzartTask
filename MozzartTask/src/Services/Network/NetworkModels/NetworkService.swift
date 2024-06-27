//
//  NetworkService.swift
//  MozzartTask
//
//  Created by Mikhail Tiranov on 24.6.24.
//

import Foundation

class NetworkService {
  
  // MARK: - Public (Properties)
  var localDecoder: JSONDecoder = {
    let jsonDecoder = JSONDecoder()
    jsonDecoder.dateDecodingStrategy = .millisecondsSince1970
    return jsonDecoder
  }()
  
  // MARK: - Private (Properties)
  private let router = Router<EndPoint>()
  
  // MARK: - Public (Interface)
  func sendRequest(
    for endPoint: EndPoint
  ) async throws -> Data {
    try await router.sendRequest(for: endPoint)
  }
}
