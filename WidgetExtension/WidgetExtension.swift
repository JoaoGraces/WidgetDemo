//
//  WidgetExtension.swift
//  WidgetExtension
//
//  Created by Luca on 01/11/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    let data = DataService()
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), streak: data.progress())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), streak: data.progress())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, streak: data.progress())
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let streak: Int
}

struct WidgetExtensionEntryView : View {
    var entry: Provider.Entry
    
    let data = DataService()

    var body: some View {
        VStack{
            ZStack{
                
                Circle()
                    .stroke(Color.black.opacity(0.12), lineWidth: 15)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(data.progress())/100)
                    .stroke(.pink.opacity(0.8), style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                    .rotationEffect(.degrees(-90))
                
                VStack{
                    Text("\(data.progress())")
                        .font(.system(size: 40))
                        .bold()
                    
                    
                }
                .foregroundStyle(.pink)
                .fontDesign(.rounded)
                
            }
            .containerBackground(.black, for: .widget)
            
            Button(intent: LogEntryAppIntent()) {
                Text("+1")
                    .foregroundStyle(.pink)
                    .font(.caption)
                
            }.backgroundStyle(.black.gradient)
            
        }
    }
}

struct WidgetExtension: Widget {
    let kind: String = "WidgetExtension"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                WidgetExtensionEntryView(entry: entry)
                    .containerBackground(.black.gradient, for: .widget)
            } else {
                WidgetExtensionEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall])
    }
}

#Preview(as: .systemSmall) {
    WidgetExtension()
} timeline: {
    SimpleEntry(date: .now, streak: 1)
    SimpleEntry(date: .now, streak: 4)
}
