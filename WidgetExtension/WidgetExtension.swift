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
            WidgedBedroomExtensionView(entry: entry)
                .containerBackground(Color("WidgetBG").gradient, for: .widget)
            
            /*
            if #available(iOS 17.0, *) {
                WidgetExtensionEntryView(entry: entry)
                    .containerBackground(Color("WidgetBG").gradient, for: .widget)
            } else {
                WidgetExtensionEntryView(entry: entry)
                    .padding()
                    .background()
            }
             */
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium])
    
            
    }
}

struct WidgedBedroomExtensionView : View {
    var entry : Provider.Entry
    @AppStorage("Energia", store: UserDefaults(suiteName: "group.Luca.WidgetDemo")) var nivelEnergia : Double = 100
    @AppStorage("EstaDormindo", store: UserDefaults(suiteName: "group.Luca.WidgetDemo")) var estado : String = "acordado"
    
    @State var timer : Timer?
    
    var body: some View {
        VStack{
            VStack{
                HStack{
                    VStack{
                        if nivelEnergia > 50 {
                            TextoWidget(texto: "Seu buddy está enérgico")
                        } else{
                            TextoWidget(texto: "Seu buddy está com sono")
                        }
                    }
                }.padding()
                
                
                
                HStack{
                    Spacer()
                    
                    VStack{
                        if estado == "dormindo" {
                            ImagemWidget(imagem: Image("Buddy"))
                                .rotationEffect(.degrees(90))
                        } else {
                            ImagemWidget(imagem: Image("Buddy"))
                        }
                        Spacer()
                    }
                    
                    
                    Spacer()
                    
                    
                    Button (intent: TrocarEstadoAppIntent()){
                        ZStack{
                            RoundedRectangle(cornerRadius: 12)
                            if estado == "acordado" {
                                Text("Dormir")
                                    .foregroundStyle(.white)
                                    .bold()
                            } else {
                                Text("Acordar")
                                    .foregroundStyle(.white)
                                    .bold()
                            }
                        }
                        
                    }.padding(.bottom)
                        .frame(width: 120, height: 75)
                }
            }
        }.onAppear(perform: {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
                if estado == "acordado" {
                    if nivelEnergia > 0 {
                        DataService().diminuirEnergia()
                    }
                } else {
                    if nivelEnergia < 100 {
                        DataService().aumentarEnergia()
                    }
                    
                    if nivelEnergia == 100 {
                        DataService().mudarEstado()
                        WidgetCenter.shared.reloadTimelines(ofKind: "WidgetExtension")
                    }
                }
                
            }
        })
    }
}

struct TextoWidget : View {
    var texto : String
    
    var body : some View {
        Text(texto)
            .font(.headline)
            .fontWeight(.bold)
            .foregroundStyle(.white.gradient)
            .padding(.top)
    }
}

struct ImagemWidget : View {
    var imagem : Image
    
    var body: some View {
        imagem
            .resizable()
            .scaledToFill()
            .frame(width: 100, height: 100)
            .padding(.bottom)
    }
}

#Preview(as: .systemSmall) {
    WidgetExtension()
} timeline: {
    SimpleEntry(date: .now, streak: 1)
    SimpleEntry(date: .now, streak: 4)
}
