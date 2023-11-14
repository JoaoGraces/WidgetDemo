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
    func perform() async throws -> some ProvidesDialog & ShowsSnippetView {
        
        let data = DataService()
        data.mudarEstado()
        
        return .result(dialog: "Seu buddy está \(data.mostrarEstado())") // dialog: "O seu buddy agora está \(data.mostrarEstado())")
    }
}

struct DormirAppIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Colocar o buddy para dormir"
    
    static var description = IntentDescription("ele vai dormir")
    // Intent para aumentar a barra / alimentar o buddy
    func perform() async throws -> some ProvidesDialog & ShowsSnippetView {
        
        let data = DataService()
        data.dormirBuddy()
        
        return .result(dialog: "Seu buddy está \(data.mostrarEstado())") // dialog: "O seu buddy agora está \(data.mostrarEstado())")
    }
}

struct AcordarAppIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Acordar buddy"
    
    static var description = IntentDescription("ele vai acordar")
    // Intent para aumentar a barra / alimentar o buddy
    func perform() async throws -> some ProvidesDialog & ShowsSnippetView {
        
        let data = DataService()
        data.acordarBuddy()
        
        return .result(dialog: "Seu buddy está \(data.mostrarEstado())") // dialog: "O seu buddy agora está \(data.mostrarEstado())")
    }
}
