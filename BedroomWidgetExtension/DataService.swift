//
//  DataService.swift
//  WidgetDemo
//
//  Created by Caio Marques on 10/11/23.
//

import Foundation
import SwiftUI

class DataService {
    @AppStorage("EstaDormindo", store: UserDefaults(suiteName: "group.Luca.WidgetDemo")) private var estado : String = "acordado"
    @AppStorage("energia", store: UserDefaults(suiteName: "group.Luca.WidgetDemo")) private var energia : Double = 0
    
    func aumentarEnergia () {
        if energia < 100 {
            energia += 1
        }
    }
    
    func diminuirEnergia () {
        if energia > 0 {
            energia -= 1
        }
    }
    
    func verEnergia () -> Double {
        return energia
    }
    
    func mudarEstado () {
        if estado == "dormindo" {
            estado = "acordado"
        } else {
            estado = "dormindo"
        }
    }
    
    func mostrarEstado () -> String {
        return self.estado
    }
}
