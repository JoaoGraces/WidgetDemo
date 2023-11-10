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
        SimpleEntry(date: Date(), streak: Int(data.progress()))
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), streak: Int(data.progress()))
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
    @AppStorage("hunger", store: UserDefaults(suiteName: "group.Luca.WidgetDemo")) var hunger: Int = 0

    var body: some View {
        VStack{
            HStack{
                // Progress Bar de fome
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                            .opacity(0.3)
                            .foregroundColor(Color(UIColor.systemTeal))
                        Rectangle()
                            .frame(width: max(min(CGFloat(hunger) * geometry.size.width / 100, geometry.size.width), 0), height: geometry.size.height)
                            .foregroundColor(Color(UIColor.systemBlue))
                            .animation(.linear(duration: 0.5), value: hunger)
                        
                    }.cornerRadius(45.0)
                }
                    .frame(height: 20)
                Button(intent: LogEntryAppIntent()){
                    Image(systemName: "fork.knife.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(.green)
                }
            }
           Spacer()
            Image("Buddy")
                .resizable()
                .scaledToFit()
        }
    }
}

struct WidgetExtension: Widget {
    let kind: String = "WidgetExtension"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                WidgetExtensionEntryView(entry: entry)
                    .containerBackground(Color("WidgetBG").gradient, for: .widget)
            } else {
                WidgetExtensionEntryView(entry: entry)
                    .padding()
                    .background()
            }
             
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium])
    
            
    }
}



#Preview(as: .systemSmall) {
    WidgetExtension()
} timeline: {
    SimpleEntry(date: .now, streak: 1)
    SimpleEntry(date: .now, streak: 4)
}
