//
//  Armario.swift
//  WidgetDemo
//
//  Created by Luca on 13/11/23.
//

import SwiftUI
import WidgetKit

struct Armario: View {
    
    @AppStorage("clothes", store: UserDefaults(suiteName: "group.Luca.WidgetDemo")) var clothes: String = "Buddy"

    var body: some View {
        VStack{
            Image(clothes)
                .resizable()
                .scaledToFit()
            
            HStack{
                Button{
                    clothes = "Buddy"
                    WidgetCenter.shared.reloadTimelines(ofKind: "WidgetArmarioExtension")
                }
                label: {
                    Image(systemName: "fork.knife.circle")
                        .resizable()
                        .frame(width: 100, height: 100)
                }
                Button{
                    clothes = "chapeuBuddy"
                    WidgetCenter.shared.reloadTimelines(ofKind: "WidgetArmarioExtension")
                }
                label: {
                    Image(systemName: "fork.knife.circle")
                        .resizable()
                        .frame(width: 100, height: 100)
                }
            }.padding(.horizontal)
            HStack{
                Button{
                    clothes = "Buddy"
                    WidgetCenter.shared.reloadTimelines(ofKind: "WidgetArmarioExtension")
                }
            label: {
                Image(systemName: "fork.knife.circle")
                    .resizable()
                    .frame(width: 100, height: 100)
            }
                Button{
                    clothes = "BuddyDormindo"
                    WidgetCenter.shared.reloadTimelines(ofKind: "WidgetArmarioExtension")
                }
            label: {
                Image(systemName: "fork.knife.circle")
                    .resizable()
                    .frame(width: 100, height: 100)
            }
            }.padding(.horizontal)
        }
    }
}

#Preview {
    Armario()
}
