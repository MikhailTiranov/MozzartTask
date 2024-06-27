//
//  URLComponents+Extension.swift
//  MozzartTask
//
//  Created by Mikhail Tiranov on 24.6.24.
//

import Foundation

extension URLComponents {
  mutating func setQueryItems(
    with parameters: [String: String]?
  ) {
    guard let parameters = parameters else { return }
    queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
  }
}
