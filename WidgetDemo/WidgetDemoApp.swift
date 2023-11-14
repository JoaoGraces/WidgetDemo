//
//  WidgetDemoApp.swift
//  WidgetDemo
//
//  Created by Luca on 01/11/23.
//

import SwiftUI
import WidgetKit

@main
struct WidgetDemoApp: App {
    @StateObject var viewModel = AcessorioViewModel()
    @StateObject private var vm = CKPushNotificationViewModel()

    var body: some Scene {
        WindowGroup {
//            CKUserView()
            TabBarView().environment(\.managedObjectContext, viewModel.container.viewContext)
        }
    }
}
