//
//  Kitchen.swift
//  WidgetDemo
//
//  Created by João Victor Bernardes Gracês on 06/11/23.
//

import SwiftUI

struct Kitchen: View {
    var body: some View {
        VStack {
            Text("Cuide do seu Buddy")
                .font(.title)
                .bold()
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .opacity(0.12)
                    .frame(height: 40)
                    .padding()
                RoundedRectangle(cornerRadius: 20)
                    .trim(from: 0, to: 0.3)
                    .frame(height: 40)
                    .padding()
            }
                
            Spacer()
            Image("Buddy")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            Button {
                
            } label: {
                RoundedRectangle(cornerRadius: 25)
                    .frame(height: 50)
                    .foregroundStyle(.green)
                    .padding()
                    .overlay (
                        HStack {
                            Text("Alimente seu Buddy")
                                .foregroundStyle(.black)
                                .font(.callout)
                            Image(systemName: "fork.knife.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 35)
                                .foregroundStyle(.black)
                                .padding(.horizontal, 5)
                        }
                    )
            }
            Spacer()
        }
    }
}

#Preview {
    Kitchen()
}


