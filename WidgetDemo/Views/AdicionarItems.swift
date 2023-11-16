//
//  AdicionarItems.swift
//  WidgetDemo
//
//  Created by Gabriel Ribeiro Noronha on 14/11/23.
//

import SwiftUI

struct AdicionarItems: View {
    @StateObject private var vm = CkCrudViewModel()
    
    var body: some View {
        NavigationStack{
            VStack{
                header
                textField
                precoTextField
                addButton
                list
                Spacer()
                CKPushNotificationView()
            }
            .padding()
            .navigationBarHidden(true)
            
        }
    }
}

#Preview {
    AdicionarItems()
}


extension AdicionarItems {
    private var header: some View {
        Text("Adicione um novo item na loja")
            .font(.headline)
            .underline()
    }
    
    private var textField: some View {
        TextField("Nome do item", text: $vm.text)
            .frame(height: 55)
            .padding(.leading)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
    }
    
    private var precoTextField: some View {
        TextField("Preco", text: Binding<String>(
            get: { "\(vm.precoitem)" },
            set: {
                if let newValue = Int($0) {
                    vm.precoitem = newValue
                }
            }
        ))
            .frame(height: 55)
            .padding(.leading)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
    }
    
    private var addButton: some View{
        Button(action: {
            vm.addButtonPressed()
        }, label: {
            Text("Adicionar")
                .font(.headline)
                .foregroundStyle(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.pink.opacity(0.8))
                .cornerRadius(10.0)
            
        })
    }
    
    private var list: some View {
        List{
            ForEach(vm.items, id: \.self) { item in
                HStack {
                    Text(item.name)
                    Text(item.preco.description)
                    
//                    Text(item.preco)
//                    if let url = item.imageURL, let data = try? Data(contentsOf: url), let image = UIImage(data: data){
//                        Image(uiImage: image)
//                            .resizable()
//                        frame(width: 20, height: 20)
//                    }
                }
//                .onTapGesture {
////                    vm.updateItem(fruit: fruit)
//                }
            }
            .onDelete(perform: vm.deleteItem)
        }
        .listStyle(PlainListStyle())
        .cornerRadius(10)
    }
}
