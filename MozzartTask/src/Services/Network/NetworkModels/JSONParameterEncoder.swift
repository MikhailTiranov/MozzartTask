//
//  JSONParameterEncoder.swift
//  MozzartTask
//
//  Created by Mikhail Tiranov on 24.6.24.
//

import Foundation

protocol ParameterEncoder {
  static func encode(
    urlRequest: inout URLRequest,
    with parameters: [String: Any?]
  ) throws
}

struct JSONParameterEncoder: ParameterEncoder {
  
  // MARK: - Static (Interface)
  static func encode(
    urlRequest: inout URLRequest,
    with parameters: [String: Any?]
  ) throws {
    do {
      let jsonAsData = try JSONSerialization.data(
        withJSONObject: parameters,
        options: .prettyPrinted
      )
      
      urlRequest.httpBody = jsonAsData
    } catch {
      print(URLEncodingError.encodingFailed.rawValue)
    }
  }
}

enum URLEncodingError: String, Error {
  case encodingFailed = "Encoding of parameters of json was failed"
}
