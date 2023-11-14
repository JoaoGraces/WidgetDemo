//
//  TabBarView.swift
//  WidgetDemo
//
//  Created by Caio Marques on 09/11/23.
//

import SwiftUI
import WidgetKit

struct TabBarView: View {
    var body: some View {
        ZStack{
            TabView {
                Kitchen()
                    .tabItem {
                    Image(systemName: "fork.knife")
                }
                
                Bedroom().tabItem {
                    Image(systemName: "bed.double.fill")
                }
                
                Armario().tabItem {
                    Image(systemName: "hanger")
                }
            }
        }
        
    }
}

#Preview {
    TabBarView()
}
