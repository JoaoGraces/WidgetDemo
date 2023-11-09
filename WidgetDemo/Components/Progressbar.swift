import SwiftUI
import WidgetKit
// Barra de fome
struct ProgressBar: View {
    @Binding var value: Double
    @AppStorage("hunger", store: UserDefaults(suiteName: "group.Luca.WidgetDemo")) var hunger: Int = 0
    
    // Valores relacionados ao passar do tempo

    var attRate:  Double = 0.1
    var interval: Double = 10
    var frase : String = ""
    var isTimeActivated: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                Rectangle()
                    .frame(width: max(min(CGFloat(value) * geometry.size.width / 100, geometry.size.width), 0), height: geometry.size.height)
                    .foregroundColor(Color(UIColor.systemBlue))
                    .animation(.linear(duration: 0.5), value: value)

                HStack {
                    Spacer()
                    Text(String(format: "%.0f", value * 100) + "% \(frase)")
                }
                .padding(.horizontal)
           
            }.cornerRadius(45.0)
        }
    }

        // Quando a view aparece é carregado o valor do binding
//        .onAppear() {
//            value = hunger
//            if value > 0 {
//                startTime()
//            }
//        }
//        .onChange(of: hunger) { oldValue, newValue in
//            value = newValue
//            hunger = value
//            // Caso o valor antigo seja menor que 0 ele chama a funcao novamente para ela entrar no else e parar o timer
//            if oldValue <= 0 {
//                startTime()
//            }
//        }
//    }
//
//    func startTime() {
//        Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
//            if value <= 0 {
//                timer.invalidate()
//            } else {
//                hunger -= attRate
//                value = hunger
//                // Fazer o widget atualizar
//                WidgetCenter.shared.reloadTimelines(ofKind: "WidgetExtension")
//            }
//        }
//    }
}
