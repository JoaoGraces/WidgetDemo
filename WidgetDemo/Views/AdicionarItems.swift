//
//  AdicionarItems.swift
//  WidgetDemo
//
//  Created by Gabriel Ribeiro Noronha on 14/11/23.
//

import SwiftUI

struct AdicionarItems: View {
    @StateObject private var vm = CkCrudViewModel()
    @State var selectedImage: Image?
    @State var imagem: UIImage?
    @State private var isImagePickerPresented: Bool = false
    var body: some View {
        NavigationStack{
            VStack{
                header
                textField
                precoTextField
                addButton
                addImageButton
                list
                
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
            imagem = selectedImage.asUIImage()
            vm.addButtonPressed(image: imagem!)
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
    
    private var addImageButton: some View{
        Button("Selecionar Imagem") {
            isImagePickerPresented.toggle()
        }
        .sheet(isPresented: $isImagePickerPresented, onDismiss: loadImage) {
            ImagePickerModel(selectedImage: $selectedImage)
        }.font(.headline)
            .foregroundStyle(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.pink.opacity(0.8))
            .cornerRadius(10.0)
    }
    
    func loadImage() {
        // Lógica para carregar a imagem selecionada
        // Pode ser deixado em branco se você só precisa da imagem na variável `selectedImage`
    }
    
    private var list: some View {
        
            ForEach(vm.items, id: \.self) { item in
                HStack {
                    if let url = item.imageURL, let data = try? Data(contentsOf: url), let image = UIImage(data: data){
                        Image(uiImage: image).resizable().frame(width: 50, height: 50)
                    }
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
            
    }
}


extension View {
    // This function changes our View to UIView, then calls another function
    // to convert the newly-made UIView to a UIImage.
    public func asUIImage() -> UIImage {
        let controller = UIHostingController(rootView: self)
        
        // Set the background to be transparent incase the image is a PNG, WebP or (Static) GIF
        controller.view.backgroundColor = .clear
        
        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
        UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)
        
        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.sizeToFit()
        
        // here is the call to the function that converts UIView to UIImage: `.asUIImage()`
        let image = controller.view.asUIImage()
        controller.view.removeFromSuperview()
        return image
    }
}

extension UIView {
    // This is the function to convert UIView to UIImage
    public func asUIImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
