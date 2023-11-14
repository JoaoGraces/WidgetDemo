//
//  LojaView.swift
//  WidgetDemo
//
//  Created by Caio Marques on 08/11/23.
//

import SwiftUI

struct Produto : Identifiable {
    var id : UUID
    var nome : String
    var preco : Int
    var imagem : UIImage
}


struct LojaView: View {
    @State var moedas = 1000
    
    var body: some View {
        VStack {
            HStack{
                Text("Loja")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                Text(moedas.description)
                Image(systemName: "bitcoinsign.circle")
                    .foregroundStyle(.yellow)
            }.padding(.horizontal)
            VStack{
                ListaItensLoja(listaItensLoja: [Produto(id: UUID(), nome: "pirulito", preco: 10, imagem: UIImage(named: "pirulito")!), Produto(id: UUID(), nome: "chapeu", preco: 100, imagem: UIImage(named: "chapeu")!), Produto(id: UUID(), nome: "cartola", preco: 10, imagem: UIImage(named: "cartola")!), Produto(id: UUID(), nome: "gravata", preco: 50, imagem: UIImage(named: "gravata")!)], moedas: $moedas, ehLoja: true)
                
                
                Spacer()
            }
        }
    }
}

#Preview {
    LojaView()
}
