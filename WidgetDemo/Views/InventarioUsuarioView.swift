//
//  InventarioUsuarioView.swift
//  WidgetDemo
//
//  Created by Caio Marques on 08/11/23.
//

import SwiftUI

struct InventarioUsuarioView: View {
    let viewModel = AcessorioViewModel()
    #warning("isso aqui não é pra acontecer, não é pra ter necessidade de fazer uma atrocidade dessas com o código...")
    @State var moedas : Int = 0
    @Environment (\.managedObjectContext) var moc
    
    var body: some View {
        NavigationView {
            VStack{
                HStack{
                    Text("Inventário")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                }.padding()
                
                ListaItensLoja(listaItensLoja: viewModel.retornarAcessoriosComprados(contexto: moc), moedas: $moedas, ehLoja: true)
            }
        }
            
    }
}

#Preview {
    InventarioUsuarioView()
}
