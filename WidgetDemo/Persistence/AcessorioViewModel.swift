//
//  AcessorioViewModel.swift
//  WidgetDemo
//
//  Created by Caio Marques on 08/11/23.
//

import Foundation
import CoreData
import UIKit

class AcessorioViewModel : ObservableObject {
    var container : NSPersistentContainer = NSPersistentContainer(name: "DataModel")
    
    init () {
        container.loadPersistentStores { descricao, erro in
            if let erro = erro {
                print("Deu erro... \(erro)")
            }
        }
    }
    
    func save (contexto : NSManagedObjectContext) {
        do {
            try contexto.save()
        } catch {
            print("Erro ao salvar... \(error)")
        }
    }
    
    func comprarAcessorio (produto : Produto, contexto : NSManagedObjectContext) {
        let acessorio = Acessorio(context: contexto)
        acessorio.idAcessorio = UUID()
        acessorio.nome = produto.nome
        acessorio.preco = Int32(produto.preco)
        acessorio.imagem = produto.imagem.jpegData(compressionQuality: 100)
        save(contexto: contexto)
    }
    
    func retornarAcessoriosComprados (contexto : NSManagedObjectContext) -> [Produto] {
        var produtos : [Produto] = []
        do {
            let acessorios = try contexto.fetch(Acessorio.fetchRequest())
            for acessorio in acessorios {
                let produto = Produto(id: acessorio.idAcessorio!, nome: acessorio.nome!, preco: Int(exactly: acessorio.preco)!, imagem: UIImage(data: acessorio.imagem!)!)
                
                produtos.append(produto)
            }
        } catch {
            print("Deu erro no fetch dos produtos: \(error)")
        }
        
        return produtos
        
    }
}
