//
//  Bedroom.swift
//  WidgetDemo
//
//  Created by Caio Marques on 07/11/23.
//

import SwiftUI

struct Bedroom: View {
    @State var nivelEnergia : Double = 1
    @State var estado : EstadoBuddy = .ACORDADO
    @State var timer : Timer?
    
    var body: some View {
        VStack{
            HStack{
                VStack (alignment: .leading){
                    Text("Como está seu buddy")
                        .font(.title)
                        .bold()
                    ProgressBar(value: $nivelEnergia, frase: "energia")
                        .frame(height: 40)
                        .padding()
                    if nivelEnergia > 0.5 {
                        Text("Seu buddy está enérgico")
                    } else if nivelEnergia > 0.1 {
                        Text("Seu buddy está com sono")
                    } else {
                        Text("Seu buddy está morrendo de sono 😭")
                    }
                }
                
                Spacer()
            }.padding()
            
            Spacer()
        
            if estado == .DORMINDO {
                Image("Buddy")
                    .rotationEffect(.degrees(90))
            } else {
                Image("Buddy")
            }
            
            Spacer()
            
            Button {
                if estado == .ACORDADO {
                    estado = .DORMINDO
                } else {
                    estado = .ACORDADO
                }
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 12.0)
                        .frame(width: 200, height: 40)
                    if estado == .ACORDADO {
                        Text("Dormir")
                            .foregroundStyle(.background)
                    } else {
                        Text("Acordar")
                            .foregroundStyle(.background)
                    }
                    
                }
                
            }
            
        }.onAppear(perform: {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
                if estado == .ACORDADO {
                    if nivelEnergia > 0 {
                        diminuirEnergia()
                    }
                } else {
                    if nivelEnergia < 1 {
                        aumentarEnergia()
                    }
                    
                    if nivelEnergia == 1 {
                        estado = .ACORDADO
                    }
                }
                
            }
        })
    }
    
    
    func aumentarEnergia () {
        nivelEnergia += 0.01
    }
    func diminuirEnergia () {
        nivelEnergia -= 0.01
    }
   
}


#Preview {
    Bedroom()
}

enum EstadoBuddy {
    case ACORDADO, DORMINDO, DORMINDO_DESCANSADO
}

enum EstadoSonoBuddy {
    case SONO, SONINHO, ENERGICO
}
