
import SwiftUI

struct FocusTimerScreen: View {
    @StateObject private var viewModel = TimerViewModel()
    
    var body: some View {
        ZStack {
            // خلفية البحر المتحركة
            SeaBackground()
            
            VStack {
                Spacer()
                
                Group {
                    switch viewModel.mode {
                    case .selecting:
                        // شاشة اختيار الوقت (الدائرة + السلايدر)
                        CircularSelectionTimerView(viewModel: viewModel)
                        
                    case .running, .finished:
                        // شاشة الجيلي فِش أثناء التايمر / بعد ما يخلص
                        JellyfishFocusView(viewModel: viewModel)
                    }
                }
                .offset(y: -40)   // ترفعين المحتوى شوي لفوق
                
                Spacer()
            }
        }
    }
}

#Preview {
    FocusTimerScreen()
}
