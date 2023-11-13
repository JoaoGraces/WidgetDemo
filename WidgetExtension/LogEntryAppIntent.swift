//
//  LogEntryAppIntent.swift
//  WidgetExtensionExtension
//
//  Created by Luca on 01/11/23.
//

import Foundation
import AppIntents

struct LogEntryAppIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Log an entry to your streak."
    
    static var description = IntentDescription("Adds 1 to your streak.")
    // Intent para aumentar a barra / alimentar o buddy
    func perform() async throws -> some ProvidesDialog & ShowsSnippetView {
        
        let data = DataService()
        data.log()
        
        return .result(dialog: "Seu Buddy está \(data.progress())% alimentado")
    }
}
