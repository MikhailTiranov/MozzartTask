//
//  Router.swift
//  MozzartTask
//
//  Created by Mikhail Tiranov on 24.6.24.
//

import Foundation
import Combine

final class Router<EndPoint: RestEndPointType> {
  
  // MARK: - Private (Properties)
  private let requestManager = RequestBuilder<EndPoint>()
  
  // MARK: - Public (Interface)
  private func makeRequest(
    for endpoint: EndPoint
  ) throws -> URLRequest {
    do {
      return try requestManager.buildRequest(from: endpoint)
    } catch {
      throw RequestError.badRequest
    }
  }
  
  func sendRequest(for endpoint: EndPoint) async throws -> Data {
    let (data, response) = try await URLSession.shared.data(
      for: makeRequest(for: endpoint)
    )
    
    let statusCode = (response as! HTTPURLResponse).statusCode
    
    switch statusCode {
    case 200..<300:
      return data
    case 400...499:
      fallthrough
    case 500:
      fallthrough
    default:
      throw RequestError.networkError(
        URLError(
          URLError.Code(rawValue: statusCode)
        )
      )
    }
  }
}
