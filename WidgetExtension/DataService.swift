//
//  DataService.swift
//  WidgetExtensionExtension
//
//  Created by Luca on 01/11/23.
//

import Foundation
import SwiftUI

struct DataService {
    
    @AppStorage("streak", store: UserDefaults(suiteName: "group.Luca.WidgetDemo")) private var streak = 0
    
    func log() {
        if streak >= 100 {
            streak = 0
        } else {
            streak += 1
        }
       
    }
    
    func progress() -> Int {
        return streak
    }
    
    func reset() {
        streak = 0
    }
}
