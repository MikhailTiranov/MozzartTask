//
//  RestEndPointType.swift
//  MozzartTask
//
//  Created by Mikhail Tiranov on 24.6.24.
//

import Foundation

protocol RestEndPointType {
  var scheme: String { get }
  var host: String { get }
  var path: String { get }
  var queryItems: [String: String]? { get }
  var bodyParameters: [String: Any?]? { get }
  var httpMethod: HTTPMethod { get }
  var headers: [String: String]? { get }
}
