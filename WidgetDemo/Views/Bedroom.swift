//
//  Bedroom.swift
//  WidgetDemo
//
//  Created by Caio Marques on 07/11/23.
//

import SwiftUI
import WidgetKit

struct Bedroom: View {
    //@State var nivelEnergia : Double = 100
    @State var timer : Timer?
    
    @State var abriuLoja = false
    @State var abriuInventario = false
    
    @State var nomeImagem = "Buddy"
    
    
    @AppStorage("Energia", store: UserDefaults(suiteName: "group.Luca.WidgetDemo")) var nivelEnergia : Double = 100
    @AppStorage("clothes", store: UserDefaults(suiteName: "group.Luca.WidgetDemo")) var clothes : String = "Buddy"
    @AppStorage("EstaDormindo", store: UserDefaults(suiteName: "group.Luca.WidgetDemo")) var estado : String = "acordado"
    
    var body: some View {
        VStack{
            HStack{
                VStack (alignment: .leading){
                    HStack{
                        Spacer()
                        Button {
                            abriuInventario = true
                        } label: {
                            Image(systemName: "tray.fill")
                                .font(.title2)
                        }
                        
                        Button {
                            abriuLoja = true
                        } label: {
                            Image(systemName: "cart")
                                .font(.title2)
                        }
                    }.padding(.bottom)
                    
                    
                    Text("Como está seu buddy")
                        .font(.title)
                        .bold()
                    ProgressBar(value: $nivelEnergia, frase: "energia")
                        .frame(height: 40)
                        .padding()
                    if nivelEnergia > 50 {
                        Text("Seu buddy está enérgico")
                    } else if nivelEnergia > 10 {
                        Text("Seu buddy está com sono")
                    } else {
                        Text("Seu buddy está morrendo de sono 😭")
                    }
                }
                
                Spacer()
            }.padding()
            
            Spacer()
        
            
            Image(nomeImagem)
                .resizable()
                .scaledToFit()
                .frame(height: 300)
            
            Spacer()
            
            Button {
                if estado == "acordado" {
                    nomeImagem = "BuddyDormindo"
                    estado = "dormindo"
                } else {
                    nomeImagem = self.clothes
                    estado = "acordado"
                }
                WidgetCenter.shared.reloadTimelines(ofKind: "WidgetExtension")
                
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 12.0)
                        .frame(width: 200, height: 40)
                    if estado == "acordado" {
                        Text("Dormir")
                            .foregroundStyle(.background)
                    } else {
                        Text("Acordar")
                            .foregroundStyle(.background)
                    }
                }
            }
            
            
            
        }.sheet(isPresented: $abriuInventario, content: {
            InventarioUsuarioView()
        })
        .sheet(isPresented: $abriuLoja, content: {
            LojaView()
        })
        .onAppear(perform: {
            self.nomeImagem = estado == "acordado" ? self.clothes : "BuddyDormindo"
            
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
                if estado == "acordado" {
                    if nivelEnergia > 0 {
                        diminuirEnergia()
                    }
                } else {
                    if nivelEnergia < 100 {
                        aumentarEnergia()
                    }
                    
                    if nivelEnergia >= 100 {
                        estado = "acordado"
                        nomeImagem = self.clothes
                        WidgetCenter.shared.reloadTimelines(ofKind: "WidgetExtension")
                    }
                }
                
            }
        })
    }
    
    func aumentarEnergia () {
        nivelEnergia += 1
        WidgetCenter.shared.reloadTimelines(ofKind: "WidgetExtension")

    }
    func diminuirEnergia () {
        nivelEnergia -= 1
        WidgetCenter.shared.reloadTimelines(ofKind: "WidgetExtension")

    }
   
}


#Preview {
    Bedroom()
}

enum EstadoBuddy {
    case ACORDADO, DORMINDO
}

enum EstadoSonoBuddy {
    case SONO, SONINHO, ENERGICO
}
