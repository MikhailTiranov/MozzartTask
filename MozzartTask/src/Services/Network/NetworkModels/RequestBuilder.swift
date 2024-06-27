//
//  RequestBuilder.swift
//  MozzartTask
//
//  Created by Mikhail Tiranov on 24.6.24.
//

import Foundation

class RequestBuilder<EndPoint: RestEndPointType> {
  
  // MARK: - Public (Interface)
  func buildRequest(from endpoint: EndPoint) throws -> URLRequest {
    let urlComponents = buildComponents(from: endpoint)
    let url = urlComponents.url!
    var request = URLRequest(url: url)
    
    request.httpMethod = endpoint.httpMethod.rawValue
    
    configureHeaders(from: endpoint, for: &request)
    try configureParameters(from: endpoint, for: &request)
    
    return request
  }
  
  // MARK: - Private (Interface)
  private func buildComponents(from endpoint: EndPoint) -> URLComponents {
    var urlComponents = URLComponents()
    
    urlComponents.scheme = endpoint.scheme
    urlComponents.host = endpoint.host
    urlComponents.path = endpoint.path
    urlComponents.setQueryItems(with: endpoint.queryItems)
    
    return urlComponents
  }
  
  private func configureHeaders(
    from endpoint: EndPoint,
    for request: inout URLRequest
  ) {
    guard let fields = endpoint.headers else { return }
    
    for (field, value) in fields {
      request.setValue(value, forHTTPHeaderField: field)
    }
  }
  
  private func configureParameters(
    from endpoint: EndPoint,
    for request: inout URLRequest
  ) throws {
    guard let bodyParameters = endpoint.bodyParameters else { return }
    try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
  }
}
