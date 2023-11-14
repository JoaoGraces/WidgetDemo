//
//  Armario.swift
//  WidgetDemo
//
//  Created by Luca on 13/11/23.
//

import SwiftUI
import WidgetKit

struct Armario: View {
    @Environment (\.managedObjectContext) var moc
    let vm = AcessorioViewModel()

    @AppStorage("clothes", store: UserDefaults(suiteName: "group.Luca.WidgetDemo")) var clothes: String = "Buddy"

    var body: some View {
        VStack{
            Image(clothes)
                .resizable()
                .scaledToFit()
                .frame(height: 300)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
                
                ForEach(vm.retornarAcessoriosComprados(contexto: moc)) { item in
                    AcessorioView(clothes: $clothes, nomeIconeAcessorio: item.nome, nomeImagemBuddy: "\(item.nome)Buddy")
                }
            })
            
            Button ("Tirar acessórios") {
                self.clothes = "Buddy"
            }
        }
    }
}

struct AcessorioView : View {
    @Binding var clothes : String
    
    var nomeIconeAcessorio : String?
    var nomeImagemBuddy : String
    
    var body: some View {
        Button{
            clothes = nomeImagemBuddy
            WidgetCenter.shared.reloadTimelines(ofKind: "WidgetArmarioExtension")
        }
        label: {
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.blue.gradient.opacity(0.7))
                if let nomeIconeAcessorio = nomeIconeAcessorio {
                    Image(nomeIconeAcessorio)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        
                } else {
                    Image(systemName: "fork.knife")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
            }
        }
    }
}

#Preview {
    Armario()
}
