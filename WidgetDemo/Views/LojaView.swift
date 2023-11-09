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
                ListaItensLoja(listaItensLoja: [Produto(id: UUID(), nome: "Lápis", preco: 10, imagem: UIImage(systemName: "pencil")!), Produto(id: UUID(), nome: "Chapéu", preco: 100, imagem: UIImage(systemName: "square.and.arrow.up")!), Produto(id: UUID(), nome: "Corinthians", preco: 10, imagem: UIImage(systemName: "doc.fill")!), Produto(id: UUID(), nome: "Sapato", preco: 50, imagem: UIImage(systemName: "pencil")!)], moedas: $moedas, ehLoja: true)
                
                
                Spacer()
            }
        }
    }
}

#Preview {
    LojaView()
}
