//
//  ShortcutProvider.swift
//  WidgetDemo
//
//  Created by Caio Marques on 13/11/23.
//

import Foundation
import AppIntents
import SwiftUI

struct ShortcutProvider : AppShortcutsProvider {
    @AppShortcutsBuilder
    static var appShortcuts: [AppShortcut] {
        return [
            AppShortcut(intent: DormirAppIntent(), phrases: ["Coloque meu monstrinho para dormir no \(.applicationName)"], shortTitle: "dormir buddy", systemImageName: "powersleep"),
            AppShortcut(intent: AcordarAppIntent(), phrases: ["Acorde meu monstrinho no \(.applicationName)"], shortTitle: "acordar buddy", systemImageName: "sun.min"),
            AppShortcut(intent: LogEntryAppIntent(), phrases: ["Alimente meu monstrinho no \(.applicationName)"], shortTitle: "alimentar", systemImageName: "carrot")
        
        ]
    }
}
