//
//  Color+Extension.swift
//  MozzartTask
//
//  Created by Mihail Tiranov on 28.6.24..
//


import SwiftUI
import UIKit

// MARK: - Color
extension Color {
  static var primaryText: Color { .white }
  
  static var secondaryText: Color { .white.opacity(0.8) }
  static var darkText: Color { .black.opacity(0.8) }
  
  static var primary: Color { .yellow }
  static var warningColor: Color { .red }
  static var secondary: Color { .green }
  static var background: Color { .black }
  static var vagueBackground: Color { .black.opacity(0.9) }
  static var secondaryBackground: Color { .yellow.opacity(0.9) }
  static var cellBackground: Color { .yellow.opacity(0.8) }
  static var borderColor: Color { .gray }
}

extension Color {
  static let mixedColors: [Color] = [
    .yellow, .orange, .red, .pink,
    .purple, .cyan, .green, .blue,
    .mint, .indigo
  ]
}
