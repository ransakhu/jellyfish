//
//import SwiftUI
//
//struct FocusTimerScreen: View {
//    @StateObject private var viewModel: TimerViewModel
//
//    // نسمح بتمرير viewModel من برّا
//    init(viewModel: TimerViewModel = TimerViewModel()) {
//        _viewModel = StateObject(wrappedValue: viewModel)
//    }
//    
//    var body: some View {
//        ZStack {
//            // خلفية البحر المتحركة
//            SeaBackground()
//            
//            VStack {
//                Spacer()
//                
//                Group {
//                    switch viewModel.mode {
//                    case .selecting:
//                        // شاشة اختيار الوقت (الدائرة + السلايدر)
//                        CircularSelectionTimerView(viewModel: viewModel)
//                        
//                    case .running, .finished:
//                        // شاشة الجيلي فِش أثناء التايمر / بعد ما يخلص
//                        JellyfishFocusView(viewModel: viewModel)
//                    }
//                }
//                .offset(y: -40)   // ترفعين المحتوى شوي لفوق
//                
//                Spacer()
//            }
//        }
//    }
//}
//
//#Preview {
//    FocusTimerScreen()
////}
//import SwiftUI
//
//struct FocusTimerScreen: View {
//    @ObservedObject var viewModel: TimerViewModel
//    let taskName: String
//    let onDismiss: () -> Void
//    
//    var body: some View {
//        ZStack {
//            SeaBackground()
//            
//            VStack {
//                Spacer()
//                
//                Group {
//                    switch viewModel.mode {
//                    case .selecting:
//                        CircularSelectionTimerView(viewModel: viewModel)
//                        
//                    case .running, .finished:
//                        JellyfishFocusView(viewModel: viewModel)
//                    }
//                }
//                .offset(y: -40)
//                
//                Spacer()
//            }
//        }
//        .navigationBarBackButtonHidden(true)
//        .toolbar {
//            // زر Done يطلع فقط بعد ما يبدأ التايمر
//            if viewModel.hasStarted {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button("Done") {
//                        onDismiss()
//                    }
//                    .foregroundColor(.white)
//                }
//            }
//        }
//    }
//} last
import SwiftUI

struct FocusTimerScreen: View {
    @ObservedObject var viewModel: TimerViewModel
    let taskName: String
    let onDismiss: () -> Void
    
    var body: some View {
        ZStack {
            SeaBackground()
            
            VStack {
                Spacer()
                
                Group {
                    switch viewModel.mode {
                    case .selecting:
                        CircularSelectionTimerView(viewModel: viewModel)
                        
                    case .running, .finished:
                        JellyfishFocusView(viewModel: viewModel)
                    }
                }
                .offset(y: -40)
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            // أيقون X على اليسار
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    onDismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                }
            }
            
            // أيقون ✓ على اليمين - يطلع فقط في وضع الاختيار
            if viewModel.mode == .selecting {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.startFocus()
                    } label: {
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                    }
                }
            }
            
            // أو لو التايمر شغال، نعرض أيقون إيقاف/إكمال
            if viewModel.mode == .running {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        onDismiss()
                    } label: {
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}
/*

import SwiftUI

struct FocusTimerScreen: View {
    @ObservedObject var viewModel: TimerViewModel
    let taskName: String
    let onDismiss: () -> Void
    
    var body: some View {
        ZStack {
            SeaBackground()
            
            VStack {
                Spacer()
                
                Group {
                    switch viewModel.mode {
                    case .selecting:
                        CircularSelectionTimerView(viewModel: viewModel)
                        
                    case .running, .finished:
                        JellyfishFocusView(viewModel: viewModel)
                    }
                }
                .offset(y: -40)
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Done") {
                    handleDoneButton()
                }
                .foregroundColor(.white)
            }
        }
    }
    
    private func handleDoneButton() {
        if !viewModel.hasStarted {
            // الضغطة الأولى: بدء التايمر
            viewModel.startFocus()
        } else {
            // الضغطة الثانية: إغلاق الشاشة
            onDismiss()
        }
    }
}*/
