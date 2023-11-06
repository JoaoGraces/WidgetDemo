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
    
    func perform() async throws -> some IntentResult & ReturnsValue {
        
        let data = DataService()
        data.log()
        
        return .result(value: data.progress())
    }
}
