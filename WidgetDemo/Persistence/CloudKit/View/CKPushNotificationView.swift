//
//  CKPushNotificationView.swift
//  WidgetDemo
//
//  Created by Gabriel Ribeiro Noronha on 14/11/23.
//

import SwiftUI

struct CKPushNotificationView: View {
    @StateObject private var vm = CKPushNotificationViewModel()
    
    var body: some View {
        VStack(spacing: 10){
            
            Button("Request CloudKit Permission") {
                CKUserViewModel().requestPermission()
            }

            Button("Request notification Permission") {
                vm.requestNotificationPermissions()
            }
            
            Button("Subscribe to Notifications") {
                vm.SubscribeToNotifications()
            }
            
            Button("Unsubscribe to Notifications") {
                vm.unsubscribeToNotifications()
            }
        }
    }
}

#Preview {
    CKPushNotificationView()
}
