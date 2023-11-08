//
//  TimeFood.swift
//  WidgetDemo
//
//  Created by João Victor Bernardes Gracês on 07/11/23.
//

import Foundation
import WidgetKit
import SwiftUI

class TimeFood {
    
    private var value: Int
    private var attRate: Int = 10
    private var interval: Double = 3

    init(value: Int) {
        self.value = value
    }
    
    func startTime() {
          Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
              if self.value <= 0 {
                  timer.invalidate()
              } else {
                  self.value -= self.attRate
                  // Fazer o widget atualizar
                  WidgetCenter.shared.reloadTimelines(ofKind: "WidgetExtension")
              }
          }
      }
}
