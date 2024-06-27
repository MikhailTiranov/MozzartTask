//
//  Storage.swift
//  MozzartTask
//
//  Created by Mihail Tiranov on 27.6.24..
//

import Foundation

final class Storage {
  
  // MARK: - Public (Properties)
  static let shared = Storage()
  
  // MARK: - Private (Properties)
  private let userDefaults = UserDefaults.standard
  private let key = "myBets"
  
  // MARK: - Public (Interface)
  func loadBets() -> [Int:Set<Int>] {
    var myBets: [Int:Set<Int>] = [:]
    
    if
      let data = userDefaults.object(forKey: key) as? Data,
      let bets = try? JSONDecoder().decode([Int:Set<Int>].self, from: data)
    {
      myBets = bets
    }
    
    return myBets
  }
  
  func saveBet(for id: Int, numbers: Set<Int>) {
    var myBets = loadBets()
    myBets[id] = numbers
    if let encoded = try? JSONEncoder().encode(myBets) {
      UserDefaults.standard.set(encoded, forKey: key)
    }
  }
}
