//
//  DataService.swift
//  WidgetExtensionExtension
//
//  Created by Luca on 01/11/23.
//

import Foundation
import SwiftUI

struct DataService {
    // User Deafult que guarda o nivel de fome
    @AppStorage("hunger", store: UserDefaults(suiteName: "group.Luca.WidgetDemo")) private var hunger: Int = 0
    
    // Funcao para somar os valores na widget
    func log() {
        if hunger < 100 {
            hunger += 10
        }
    }
    // Funcao para retornar o valor atual da fome
    func progress() -> Int {
        return hunger
    }
    
    func startTime() {
         let attRate: Int = 10
         let interval: Double = 3
        
          Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
              if hunger <= 0 {
                  timer.invalidate()
              } else {
                  hunger -= attRate
              }
          }
      }
}
