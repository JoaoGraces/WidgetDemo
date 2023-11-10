//
//  ListaItensLoja.swift
//  WidgetDemo
//
//  Created by Caio Marques on 08/11/23.
//

import Foundation
import SwiftUI

struct ListaItensLoja : View {
    var listaItensLoja : [Produto]
    @Binding var moedas : Int
    var ehLoja : Bool
    @Environment (\.managedObjectContext) var moc
    @State var alertaApresentado = false
        
    var body: some View {
        ScrollView{
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
                ForEach(listaItensLoja) { produto in
                    Button {
                        if ehLoja {
                            if moedas >= produto.preco {
                                if AcessorioViewModel().retornarAcessoriosComprados(contexto: moc).contains(where: { elemento in
                                    elemento.nome == produto.nome
                                }) {
                                    print("NÃO DA PARA COMPRAR UM BAGULHO QUE CE JA TEM FIO")
                                } else {
                                    self.moedas -= produto.preco
                                    AcessorioViewModel().comprarAcessorio(produto: produto, contexto: moc)
                                }
                                
                            } else {
                                alertaApresentado = true
                            }
                        } else {
                            // se não, quando o usuário clica é importante a opção de equipar os acessórios no bixinho.
                        }
                    } label: {
                        ItemLoja(produto: produto)
                            .foregroundStyle(.black)
                    }.alert("Você não tem moedas o suficiente...", isPresented: $alertaApresentado) {
                        Button("OK") {}
                    }
                }
            })
            
        }
    }
    
}
