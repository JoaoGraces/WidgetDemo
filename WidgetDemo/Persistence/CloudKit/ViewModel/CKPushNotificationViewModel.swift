//
//  CKPushNotificationViewModel.swift
//  WidgetDemo
//
//  Created by Gabriel Ribeiro Noronha on 14/11/23.
//


import Foundation
import SwiftUI
import CloudKit

class CKPushNotificationViewModel: ObservableObject {
    func requestNotificationPermissions(){
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("error")
            }else if success{
                print("Notification permission Success")
                
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
                
            } else {
                print("notification permission FAIL")
            }
        }
    }
    
    func SubscribeToNotifications(){
        let predicate = NSPredicate(value: true)
        
        //sub to add
        let subscriptionADD = CKQuerySubscription(recordType: "Items", predicate: predicate, subscriptionID: "Item_Added_to_Database", options: .firesOnRecordCreation)
        
        let notificationADD = CKSubscription.NotificationInfo()
        notificationADD.title = "NEW ITEM ADDED"
        notificationADD.alertBody = "Open the app to check the New Item"
        notificationADD.soundName = "default"
        
        subscriptionADD.notificationInfo = notificationADD
        
        CKContainer.default().publicCloudDatabase.save(subscriptionADD) { returnedSubscription, returnedError in
            if let error = returnedError {
                print(error)
            } else {
                print("Sucessfully Subscripted to get NOTIFICATIONS WHEN ITEM IS ADDED")
            }
        }
        
//        //sub to del
//        let subscriptionDEL = CKQuerySubscription(recordType: "Fruits", predicate: predicate, subscriptionID: "Fruit_Deleted_to_Database", options: .firesOnRecordDeletion)
//
//        let notificationDEL = CKSubscription.NotificationInfo()
//        notificationDEL.title = "FRUIT DELETED"
//        notificationDEL.alertBody = "Open the app to check"
//        notificationDEL.soundName = "default"
//
//        CKContainer.default().publicCloudDatabase.save(subscriptionDEL) { returnedSubscription, returnedError in
//            if let error = returnedError {
//                print(error)
//            } else {
//                print("Sucessfully Subscripted to NOTIFICATIONS WHEN FRUIT DELETED")
//            }
//        }
    }
    
    func unsubscribeToNotifications(){
        
        //caso nao saiba quais Subscriptions o usuario tem
//        CKContainer.default().publicCloudDatabase.fetchAllSubscriptions(completionHandler: T##([CKSubscription]?, Error?) -> Void)
        
        CKContainer.default().publicCloudDatabase.delete(withSubscriptionID: "Fruit_Deleted_to_Database") { returnedID, returnedError in
            if let error = returnedError{
                print(error)
            }else{
                print("Sucessfully Unsubscribed")
            }
        }
    }
    
}
