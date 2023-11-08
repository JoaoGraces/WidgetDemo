//
//  Kitchen.swift
//  WidgetDemo
//
//  Created by João Victor Bernardes Gracês on 06/11/23.
//

import SwiftUI

struct Kitchen: View {
    @State var value: Double = 0
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
            ProgressBar(value: $value, frase: "alimentado")
                .frame(height: 40)
                .padding()
                
                
            Spacer()
            Image("Buddy")
                .resizable()
                .frame(width: 50 + value * 200, height: 200)
            
            Spacer()

            Button {
                if value < 0.9 {
                    value += 0.1
                }
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
        }
    }
}

#Preview {
    Kitchen()
}
