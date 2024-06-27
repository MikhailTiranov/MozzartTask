//
//  RequestError.swift
//  MozzartTask
//
//  Created by Mikhail Tiranov on 24.6.24.
//

import Foundation

enum RequestError: Error {
  case badRequest
  case networkError(URLError)
  case otherError
  case wrongModel
  
  var description: String {
    switch self {
    case .badRequest:
      "Inappropriate Request"
    case let .networkError(urlError):
      "Network Error, status code is \(urlError.code)"
    case .otherError:
      "Other Error"
    case .wrongModel:
      "Wrong Model"
    }
  }
}
