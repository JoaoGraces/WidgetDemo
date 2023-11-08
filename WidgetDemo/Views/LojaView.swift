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
    var imagem : Image
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
                ListaItensLoja(listaItensLoja: [Produto(id: UUID(), nome: "Lápis", preco: 10, imagem: Image(systemName: "pencil")), Produto(id: UUID(), nome: "Chapéu", preco: 100, imagem: Image(systemName: "square.and.arrow.up")), Produto(id: UUID(), nome: "Corinthians", preco: 10, imagem: Image(systemName: "doc.fill"))], moedas: $moedas)
                
                
                Spacer()
            }
        }
    }
}

struct ListaItensLoja : View {
    var listaItensLoja : [Produto]
    @Binding var moedas : Int
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
                ForEach(listaItensLoja) { produto in
                    Button {
                        moedas -= produto.preco
                    } label: {
                        ItemLoja(produto: produto)
                            .foregroundStyle(.black)
                    }
                }
            })
            
        }
    }
    
}




struct ItemLoja : View {
    var produto : Produto
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.blue.gradient)
                .frame(width: 180, height: 180)
            VStack{
                VStack{
                    Text(produto.nome)
                        .bold()
                    Text("\(produto.preco.description) $")
                }
                .padding(.bottom)
                produto.imagem
                    .resizable()
                    .scaledToFit()
                    .frame(height: 60)
            }
        }
    }
}

#Preview {
    LojaView()
}
