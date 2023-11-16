//
//  CKCrud.swift
//  WidgetDemo
//
//  Created by Gabriel Ribeiro Noronha on 14/11/23.
//

import Foundation
import SwiftUI
import CloudKit

class CkCrudViewModel: ObservableObject{
    
    @Published var text: String = ""
    @Published var items:[ItemModel] = []
    @Published var precoitem: Int = 0
    //    @Published var imageURL: URL?
    
    init() {
        fetchItem()
    }
    
    func addButtonPressed(image: UIImage){
        guard !text.isEmpty else { return }
        addItem(name: text, preco: precoitem, image: image)
        
        DispatchQueue.main.async{
            self.fetchItem()
        }
    }
    
    private func addItem(name: String, preco: Int, image:UIImage) {
        let newItem = CKRecord(recordType: "Items")
        newItem["name"] = name
        newItem["preco"] = preco
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Erro: Imagem não encontrada \(image)")
            return
        }
        let asset = CKAsset(fileURL: createTemporaryFile(data: imageData))
        newItem["imagem"] = asset

        saveItem(record: newItem)
        DispatchQueue.main.async {
            self.fetchItem()
        }
        
    }
    
    private func createTemporaryFile(data: Data) -> URL {
        let temporaryDirectory = FileManager.default.temporaryDirectory
        let temporaryFileURL = temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try? data.write(to: temporaryFileURL, options: [.atomic])
        return temporaryFileURL
    }
    
    private func saveItem(record: CKRecord) {
        CKContainer.default().publicCloudDatabase.save(record) {[weak self] returnedRecord, returnedError in
            print("Record: \(String(describing: returnedRecord))")
            print("Record: \(String(describing: returnedError))")
            
            DispatchQueue.main.async {
                self?.text = ""
                self?.precoitem = 0
                self?.fetchItem()
            }
        }
    }
    
    func fetchItem() {
        
        let predicate = NSPredicate(value: true)
        //        let predicate = NSPredicate(format: "name = %@", argumentArray: ["apple"]) // tipo de filtro
        
        let query = CKQuery(recordType: "Items", predicate: predicate)
        //Como ira mostrar(ordem alfabetica), primeiro ele faz o sort no resultado da query e depois mostra
        query.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let queryOperation = CKQueryOperation(query: query)
        //quantidade total de itens mostrados do BD
        // queryOperation.resultsLimit = 2
        
        var returnedItems: [ItemModel] = []
        
        queryOperation.recordMatchedBlock = {(returndID, returnedResult) in
            switch returnedResult {
            case .success(let record):
                guard let name = record["name"] as? String else {return}
                guard let preco = record["preco"] as? Int else {return}
                guard let imageAsset = record["imagem"] as? CKAsset else {print("erro fetch image")
                    return}
                let imageURL = imageAsset.fileURL
                
                //                let idAcessorio = record["idAcessorio"] as? UUID
//                let imageAsset = record["image"] as? CKAsset
//                let imageURL = imageAsset?.fileURL
                
                print(record)
                
                returnedItems.append(ItemModel(/*idAcessorio: idAcessorio,*/ name: name, imageURL: imageURL, record: record, preco: preco /*, imageURL: imageURL*/))
                //ver os tipos de dados que sao usados(pode usar pra usar na KEy de SortDescriptor)
                //                record.
                
            case .failure(let error):
                print("Error recordMatchedBlock \(error)")
            }
        }
        
        queryOperation.queryResultBlock = {[weak self]returnedResult in
            print("Returned queryResultBlock: \(returnedResult)")
            DispatchQueue.main.async{
                self?.items = returnedItems
            }
        }
        
        addOperation(operarion: queryOperation)
    }
    
    func addOperation(operarion: CKDatabaseOperation) {
        CKContainer.default().publicCloudDatabase.add(operarion)
    }
    
//    func updateItem(item:ItemModel){
//        let record = item.record
//        record["name"] = "NEW NAME"
//        saveItem(record: record)
//    }
    
    func deleteItem(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let item = items[index]
        let record = item.record
        
        CKContainer.default().publicCloudDatabase.delete(withRecordID: record.recordID) { returnedRecordID, returnedError in
            DispatchQueue.main.async{
                self.items.remove(at: index)
            }
        }
    }
}
