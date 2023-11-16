//
//  CozinhaProvider.swift
//  WidgetExtensionExtension
//
//  Created by Caio Marques on 14/11/23.
//

import Foundation
import WidgetKit
import SwiftUI

struct CozinhaEntry : TimelineEntry{
    var date: Date
    var percentualFome : Int
}

struct CozinhaProvider: TimelineProvider {
    
    let data = DataService()
    
    func placeholder(in context: Context) -> CozinhaEntry {
        CozinhaEntry(date: Date(), percentualFome: data.progress())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (CozinhaEntry) -> ()) {
        let entry = CozinhaEntry(date: Date(), percentualFome: data.progress())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<CozinhaEntry>) -> ()) {
        var entries: [CozinhaEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        var fomeAtual = data.progress()
        
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            if fomeAtual >= 10 {
                fomeAtual = fomeAtual - 10
            }
            let entry = CozinhaEntry(date: entryDate, percentualFome: fomeAtual)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
