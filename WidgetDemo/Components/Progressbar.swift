//
//  Progressbar.swift
//  WidgetDemo
//
//  Created by João Victor Bernardes Gracês on 06/11/23.
//

import SwiftUI

struct ProgressBar: View {
    @Binding var value: Double

    // Valores relacionados ao passar do tempo
    var attRate:  Double = 0.1
    var interval: Double = 10
    var isTimeActivated: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color(UIColor.systemBlue))
                    .animation(.linear(duration: 0.5), value: value)
                HStack {
                    Spacer()
                    Text(String(format: "%.0f", value * 100) + "% alimentado")
                }
                .padding(.horizontal)
           
            }.cornerRadius(45.0)
        }
        .onAppear() {
            if value > 0 && isTimeActivated {
                startTime()
            }
        }
    }
    
    func startTime() {
        Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
            value -= attRate
            if value <= 0.0 {
                timer.invalidate() // Para o timer quando o valor chega a 0 ou menos
      
            } else {
              
            }
        }
    }
}


