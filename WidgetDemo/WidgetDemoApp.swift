//
//  WidgetDemoApp.swift
//  WidgetDemo
//
//  Created by Luca on 01/11/23.
//

import SwiftUI

@main
struct WidgetDemoApp: App {
    @StateObject var viewModel = AcessorioViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabBarView().environment(\.managedObjectContext, viewModel.container.viewContext)
        }
    }
}
