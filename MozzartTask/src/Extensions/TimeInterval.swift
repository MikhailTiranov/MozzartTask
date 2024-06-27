//
//  TimeInterval.swift
//  MozzartTask
//
//  Created by Mihail Tiranov on 25.6.24.
//

import Foundation

extension TimeInterval {
  var duration: Duration { .seconds(self) }
  var positionalTime: String {
    duration
      .formatted(
        .time(
          pattern: self >= 3600.0
          ? .hourMinuteSecond
          : .minuteSecond(padMinuteToLength: 2)
        )
      )
  }
}
