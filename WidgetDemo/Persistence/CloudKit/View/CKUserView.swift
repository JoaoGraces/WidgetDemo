//
//  CKUserView.swift
//  WidgetDemo
//
//  Created by Gabriel Ribeiro Noronha on 14/11/23.
//

import SwiftUI

struct CKUserView: View {
    @StateObject private var vm = CKUserViewModel()
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("IS SIGNED IN: \(vm.isSignedInToiCloud.description.uppercased())")
                Text(vm.error)
                Text("Permission: \(vm.permissionStatus.description.uppercased())")
                Text("Nome: \(vm.userName)")
                entrarButton
                
            }
        }
    }
}

#Preview {
    CKUserView()
}

extension CKUserView{
    private var entrarButton: some View {
        NavigationLink {
            CKUserView()
        } label: {
            Text("Entrar")
                .font(.headline)
                .foregroundStyle(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.blue.opacity(0.8))
                .cornerRadius(10.0)
        }
    }
}
