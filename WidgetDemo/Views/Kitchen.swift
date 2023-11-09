//
//  Kitchen.swift
//  WidgetDemo
//
//  Created by João Victor Bernardes Gracês on 06/11/23.
//

import SwiftUI
import WidgetKit

struct Kitchen: View {
    @State var value = 0
    @AppStorage("hunger", store: UserDefaults(suiteName: "group.Luca.WidgetDemo")) var hunger: Int = 0
    
    var body: some View {
        VStack {
            Text("Cuide do seu Buddy")
                .font(.title)
                .bold()
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
            .frame(height: 40)
            .overlay (
                // Para informar a %
                HStack {
                    Spacer()
                    Text("\(hunger)% alimentado")
                }
                    .padding(.horizontal)
            )
            .padding()

            Spacer()
            Image("Buddy")
                .resizable()
                .frame(width: 200, height: 200)
            
            Spacer()

            Button {
                // Aumentando a barra de fome
                if hunger < 100 {
                    value += 10
                    hunger += 10
                }
                //Manually reload the widget
                WidgetCenter.shared.reloadTimelines(ofKind: "WidgetExtension")

            } label: {
                RoundedRectangle(cornerRadius: 25)
                    .frame(height: 50)
                    .foregroundStyle(.green)
                    .padding()
                    .overlay (
                        HStack {
                            Text("Alimente seu Buddy")
                                .foregroundStyle(.black)
                                .font(.callout)
                            Image(systemName: "fork.knife.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 35)
                                .foregroundStyle(.black)
                                .padding(.horizontal, 5)
                        }
                    )
            }
        }
        .onAppear() {
            value = hunger
            if hunger > 0 {
                startTime()
            }
        }
        .onChange(of: hunger) { oldValue, newValue in
            if oldValue <= 0 {
                startTime()
            }
            value = hunger
        }
    }
    
    // Funcoes da classe
    func startTime() {
        let attRate: Int = 10
        let interval: Double = 3600 // 1h
        
        Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
            if hunger <= 0 {
                timer.invalidate()
            } else {
                hunger -= attRate
                value = hunger
                // Fazer o widget atualizar
                WidgetCenter.shared.reloadTimelines(ofKind: "WidgetExtension")
            }
        }
    }
}

#Preview {
    Kitchen()
}
