//
//  ContentView.swift
//  WidgetDemo
//
//  Created by Luca on 01/11/23.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    
    @AppStorage("streak", store: UserDefaults(suiteName: "group.Luca.WidgetDemo")) var streak: Int = 0
    
    var body: some View {
        
        ZStack{
            Color.black
                .ignoresSafeArea()
            
            VStack (spacing: 60){
                
                ZStack{
                    Circle()
                        .stroke(Color.white.opacity(0.12), lineWidth: 20)
                    
                    Circle()
                        .trim(from: 0.0, to: CGFloat(streak)/100)
                        .stroke(.blue, style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                        .rotationEffect(.degrees(-90))
                    
                    VStack{
                        Text("Streak")
                            .font(.largeTitle)
                        Text("\(streak)")
                            .font(.system(size: 70))
                            .bold()
                            
                        
                    }
                    .foregroundStyle(.white)
                    .fontDesign(.rounded)
                    
                }
                .padding(.horizontal, 50)
                
                
                
                Button {
                    streak += 1
                    if streak > 100{
                        streak = 0
                    }
                    
                    //Manually reload the widget
                    
                    WidgetCenter.shared.reloadTimelines(ofKind: "WidgetExtension")
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.blue)
                            .frame(height: 40)
                        Text("+1")
                            .font(.title)
                            .foregroundStyle(.white)
                        
                    }
                    .padding(.horizontal, 90)
                    
                }

            }
        }
        
    }
}

#Preview {
    ContentView()
}
