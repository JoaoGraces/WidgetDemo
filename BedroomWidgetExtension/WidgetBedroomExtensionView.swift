//
//  WidgetBedroomExtensionView.swift
//  WidgetDemo
//
//  Created by Caio Marques on 10/11/23.
//

import SwiftUI
import WidgetKit


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
