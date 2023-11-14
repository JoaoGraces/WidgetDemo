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

struct LogEntryArmario1AppIntent: AppIntent {

    
    var roupa: String = "Buddy"

    init() {
        
    }
    
    static var title: LocalizedStringResource = "Change Buddy's clothes."
    
    static var description = IntentDescription("Changes Buddy's clothes according to what you pick.")
    // Intent para aumentar a barra / alimentar o buddy
    func perform() async throws -> some IntentResult & ReturnsValue<Int> {
        
        let data = DataService()
        data.mudarRoupa(roupa: roupa)
        
        return .result(value: data.progress())
    }
}

struct LogEntryArmario2AppIntent: AppIntent {

    
    var roupa: String = "chapeuBuddy"

    init() {
        
    }
    
    static var title: LocalizedStringResource = "Change Buddy's clothes."
    
    static var description = IntentDescription("Changes Buddy's clothes according to what you pick.")
    // Intent para aumentar a barra / alimentar o buddy
    func perform() async throws -> some IntentResult & ReturnsValue<Int> {
        
        let data = DataService()
        data.mudarRoupa(roupa: roupa)
        
        return .result(value: data.progress())
    }
}

struct LogEntryArmario3AppIntent: AppIntent {

    
    var roupa: String = "Buddy"

    init() {
        
    }
    
    static var title: LocalizedStringResource = "Change Buddy's clothes."
    
    static var description = IntentDescription("Changes Buddy's clothes according to what you pick.")
    // Intent para aumentar a barra / alimentar o buddy
    func perform() async throws -> some IntentResult & ReturnsValue<Int> {
        
        let data = DataService()
        data.mudarRoupa(roupa: roupa)
        
        return .result(value: data.progress())
    }
}

struct LogEntryArmario4AppIntent: AppIntent {

    
    var roupa: String = "BuddyDormindo"

    init() {
        
    }
    
    static var title: LocalizedStringResource = "Change Buddy's clothes."
    
    static var description = IntentDescription("Changes Buddy's clothes according to what you pick.")
    // Intent para aumentar a barra / alimentar o buddy
    func perform() async throws -> some IntentResult & ReturnsValue<Int> {
        
        let data = DataService()
        data.mudarRoupa(roupa: roupa)
        
        return .result(value: data.progress())
    }
}
