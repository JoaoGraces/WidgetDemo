//
//  TrocarEstadoAppIntent.swift
//  WidgetDemo
//
//  Created by Caio Marques on 09/11/23.
//

import Foundation
import AppIntents

struct TrocarEstadoAppIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Trocar estado do buddy"
    
    static var description = IntentDescription("Se ele estiver dormindo, ele vai acordar, se ele estiver acordado, ele vai dormir")
    // Intent para aumentar a barra / alimentar o buddy
    func perform() async throws -> some IntentResult & ReturnsValue<String> {
        
        let data = DataService()
        data.mudarEstado()
        
        return .result(value: data.mostrarEstado())
    }
}
