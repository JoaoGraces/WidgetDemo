//
//  DetalhamentoProduto.swift
//  WidgetDemo
//
//  Created by Caio Marques on 08/11/23.
//

import SwiftUI

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
                Image(uiImage: produto.imagem)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 60)
    
            }
        }
    }
}
