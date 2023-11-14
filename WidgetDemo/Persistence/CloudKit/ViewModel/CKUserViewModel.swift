//
//  CKUserViewModel.swift
//  WidgetDemo
//
//  Created by Gabriel Ribeiro Noronha on 14/11/23.
//
import SwiftUI
import CloudKit

class CKUserViewModel: ObservableObject {
    
    @Published var isSignedInToiCloud : Bool = false
    @Published var error : String = ""
    @Published var permissionStatus: Bool = false
    @Published var userName: String = ""
    
    init () {
        getiCloudStatus()
        requestPermission()
        fetchiCloudUserRecordID()
    }
    
    private func getiCloudStatus() {
        //verificar se o usuario esta logado na sua conta Icloud e retorna os possiveis erros
        CKContainer.default().accountStatus { [weak self] returnedStatus, returnedError in
            DispatchQueue.main.async {
                switch returnedStatus{
                case .available:
                    self?.isSignedInToiCloud = true
                case .noAccount:
                    self?.error = CKError.iCloudAccountNotFound.rawValue
                case .couldNotDetermine:
                    self?.error = CKError.iCloudAccountNotDetermined.rawValue
                case .restricted:
                    self?.error = CKError.iCloudAccountRestricted.rawValue
                default:
                    self?.error = CKError.iCloudAccountUnknown.rawValue
                }
            }
        }
    }
    
    func requestPermission(){
        CKContainer.default().requestApplicationPermission(.userDiscoverability) { [weak self] returnedStatus, returnedError in
            DispatchQueue.main.async {
                if returnedStatus == .granted {
                    self?.permissionStatus = true
                }
            }
        }
    }
    
    func fetchiCloudUserRecordID() {
        //funcao para atualizar o status do ID
        CKContainer.default().fetchUserRecordID { [weak self] returnedID, returnedError in
            if let id = returnedID {
                self?.discoveriCloudUser(id: id)
            }
        }
    }
    
    func discoveriCloudUser(id: CKRecord.ID){
        //acontee no background como uma tarefa assincrona entao tem que usar um weak self
        CKContainer.default().discoverUserIdentity(withUserRecordID: id) { [weak self] returnedIdentity, returnedError in DispatchQueue.main.async {
            if let name = returnedIdentity?.nameComponents?.givenName {
                self?.userName = name
            }
        }
        }
    }
}


#Preview {
    CKUserView()
}
