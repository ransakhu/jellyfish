//
//import SwiftUI
//
//struct CircularSelectionTimerView: View {
//    @ObservedObject var viewModel: TimerViewModel
//    
//    let size: CGFloat = 260
//    let lineWidth: CGFloat = 14
//    
//    var body: some View {
//        VStack(spacing: 24) {
//            ZStack {
//                Circle()
//                    .fill(Color(.systemGray6))
//                    .frame(width: size, height: size)
//                    .shadow(radius: 4)
//                
//                Circle()
//                    .stroke(Color(.systemGray3), lineWidth: lineWidth)
//                    .frame(width: size, height: size)
//                
//                Circle()
//                    .trim(from: 0, to: viewModel.selectionProgress)
//                    .stroke(
//                        Color(red: 0.02, green: 0.25, blue: 0.49),
//                        style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
//                    )
//                    .frame(width: size, height: size)
//                    .rotationEffect(.degrees(-90))
//                    .animation(.easeInOut(duration: 0.15),
//                               value: viewModel.selectionProgress)
//                
//                Text("\(viewModel.selectedSeconds)")
//                    .font(.system(size: 64,
//                                  weight: .medium,
//                                  design: .rounded))
//                    .foregroundColor(Color(red: 0.02,
//                                           green: 0.25,
//                                           blue: 0.49))
//            }
//            .onTapGesture {
//                // لما يضغط على الدائرة: نبدأ التايمر ونروح للجلي فِش
//                viewModel.startFocus()
//            }
//            
//            // مؤقتًا: اختيار الوقت بسلايدر (من 1 إلى 120 ثانية)
//            VStack(spacing: 8) {
//                Slider(
//                    value: Binding(
//                        get: { Double(viewModel.selectedSeconds) },
//                        set: { viewModel.updateSelection(seconds: Int($0)) }
//                    ),
//                    in: 1...Double(viewModel.maxSeconds),
//                    step: 1
//                )
//                .padding(.horizontal, 32)
//                
//                Text("Slide to choose the time, then tap the circle")
//                    .foregroundColor(.white)
//                    .font(.system(size: 15, weight: .medium))
//            }
//        }
//    }
//}



//import SwiftUI
//
//struct CircularSelectionTimerView: View {
//    @ObservedObject var viewModel: TimerViewModel
//    
//    let size: CGFloat = 260
//    let lineWidth: CGFloat = 14
//    
//    var body: some View {
//        VStack(spacing: 24) {
//            
//            ZStack {
//                // الخلفية الداخلية
//                Circle()
//                    .fill(Color(.systemGray6))
//                    .frame(width: size, height: size)
//                    .shadow(radius: 4)
//                
//                // دائرة خارجية خفيفة
//                Circle()
//                    .stroke(Color(.systemGray3), lineWidth: lineWidth)
//                    .frame(width: size, height: size)
//                
//                // دائرة تعبئة التقدم (بالدقائق)
//                Circle()
//                    .trim(from: 0, to: viewModel.selectionProgress)
//                    .stroke(
//                        Color(red: 0.02, green: 0.25, blue: 0.49),
//                        style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
//                    )
//                    .frame(width: size, height: size)
//                    .rotationEffect(.degrees(-90))
//                    .animation(.easeInOut(duration: 0.2), value: viewModel.selectionProgress)
//                
//                // ❗ عرض الوقت هنا الآن بالدقايق وليس ثواني
//                Text("\(viewModel.selectedMinutes)m")
//                    .font(.system(size: 64, weight: .medium, design: .rounded))
//                    .foregroundColor(Color(red: 0.02, green: 0.25, blue: 0.49))
//            }
//            
//            // لما يضغط يبدأ التايمر
//            .onTapGesture {
//                viewModel.startFocus()
//            }
//        }
//    }
//}





//import SwiftUI
//
//struct CircularSelectionTimerView: View {
//    @ObservedObject var viewModel: TimerViewModel
//    
//    let size: CGFloat = 260
//    let lineWidth: CGFloat = 14
//    
//    var body: some View {
//        VStack(spacing: 24) {
//            
//            ZStack {
//                // الخلفية
//                Circle()
//                    .fill(Color(.systemGray6))
//                    .frame(width: size, height: size)
//                    .shadow(radius: 4)
//                
//                // إطار خفيف
//                Circle()
//                    .stroke(Color(.systemGray3), lineWidth: lineWidth)
//                    .frame(width: size, height: size)
//                
//                // دائرة تعبئة التقدّم (من 0 إلى 120 دقيقة)
//                Circle()
//                    .trim(from: 0, to: viewModel.selectionProgress)
//                    .stroke(
//                        Color(red: 0.02, green: 0.25, blue: 0.49),
//                        style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
//                    )
//                    .frame(width: size, height: size)
//                    .rotationEffect(.degrees(-90))
//                    .animation(.easeInOut(duration: 0.2),
//                               value: viewModel.selectionProgress)   // ← انتبهي ما فيه _ ولا $
//                
//                // النص في النص يعرض الدقائق
//                Text("\(viewModel.selectedMinutes)m")
//                    .font(.system(size: 64, weight: .medium, design: .rounded))
//                    .foregroundColor(Color(red: 0.02, green: 0.25, blue: 0.49))
//            }
//            .onTapGesture {
//                // لما يضغط يبدأ التايمر
//                viewModel.startFocus()
//            }
//        }
//    }
//}




//import SwiftUI
//
//struct CircularSelectionTimerView: View {
//    @ObservedObject var viewModel: TimerViewModel
//    
//    let size: CGFloat = 260
//    let lineWidth: CGFloat = 14
//    
//    var body: some View {
//        VStack(spacing: 24) {
//            
//            ZStack {
//                // الخلفية
//                Circle()
//                    .fill(Color(.systemGray6))
//                    .frame(width: size, height: size)
//                    .shadow(radius: 4)
//                
//                // إطار خفيف
//                Circle()
//                    .stroke(Color(.systemGray3), lineWidth: lineWidth)
//                    .frame(width: size, height: size)
//                
//                // دائرة تعبئة التقدّم (من 0 إلى 120 دقيقة)
//                Circle()
//                    .trim(from: 0, to: viewModel.selectionProgress)
//                    .stroke(
//                        Color(red: 0.02, green: 0.25, blue: 0.49),
//                        style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
//                    )
//                    .frame(width: size, height: size)
//                    .rotationEffect(.degrees(-90))
//                    .animation(.easeInOut(duration: 0.2),
//                               value: viewModel.selectionProgress)   // ← انتبهي ما فيه _ ولا $
//                
//                // النص في النص يعرض الدقائق
//                Text("\(viewModel.selectedMinutes)m")
//                    .font(.system(size: 64, weight: .medium, design: .rounded))
//                    .foregroundColor(Color(red: 0.02, green: 0.25, blue: 0.49))
//            }
//            .onTapGesture {
//                // لما يضغط يبدأ التايمر
//                viewModel.startFocus()
//            }
//        }
//    }
//}



//
//import SwiftUI
//
//struct CircularSelectionTimerView: View {
//    @ObservedObject var viewModel: TimerViewModel
//    
//    let size: CGFloat = 260
//    let lineWidth: CGFloat = 14
//    
//    var body: some View {
//        VStack(spacing: 28) {
//            
//            // MARK: - دائرة التايمر
//            ZStack {
//                // الخلفية
//                Circle()
//                    .fill(Color(.systemGray6))
//                    .frame(width: size, height: size)
//                    .shadow(radius: 4)
//                
//                // إطار خفيف
//                Circle()
//                    .stroke(Color(.systemGray3), lineWidth: lineWidth)
//                    .frame(width: size, height: size)
//                
//                // تقدم الاختيار (من 0 إلى 120 دقيقة)
//                Circle()
//                    .trim(from: 0, to: viewModel.selectionProgress)
//                    .stroke(
//                        Color(red: 0.02, green: 0.25, blue: 0.49),
//                        style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
//                    )
//                    .frame(width: size, height: size)
//                    .rotationEffect(.degrees(-90))
//                    .animation(.easeInOut(duration: 0.2),
//                               value: viewModel.selectionProgress)
//                
//                // نص الوسط: الدقائق
//                Text("\(viewModel.selectedMinutes)m")
//                    .font(.system(size: 64, weight: .medium, design: .rounded))
//                    .foregroundColor(Color(red: 0.02, green: 0.25, blue: 0.49))
//            }
//            .onTapGesture {
//                // يبدأ التايمر لما يضغط على الدائرة
//                viewModel.startFocus()
//            }
//            
//            // MARK: - شريط اختيار الوقت (Glass bar)
//            ZStack {
//                // الخلفية الزجاجية
//                RoundedRectangle(cornerRadius: 24, style: .continuous)
//                    .fill(.ultraThinMaterial)          // glass effect
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 24)
//                            .stroke(Color.white.opacity(0.25), lineWidth: 1)
//                    )
//                    .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 4)
//                
//                VStack(alignment: .leading, spacing: 8) {
//                    HStack {
//                        Text("Slide to choose the time")
//                            .font(.system(size: 14, weight: .medium))
//                            .foregroundColor(.white.opacity(0.9))
//                        
//                        Spacer()
//                        
//                        Text("\(viewModel.selectedMinutes) min")
//                            .font(.system(size: 14, weight: .semibold))
//                            .foregroundColor(.white)
//                    }
//                    
//                    // السلايدر (من 1 إلى 120 دقيقة)
//                    Slider(
//                        value: Binding(
//                            get: { Double(viewModel.selectedMinutes) },
//                            set: { viewModel.updateSelection(minutes: Int($0)) }
//                        ),
//                        in: 1...Double(viewModel.maxMinutes),
//                        step: 1
//                    )
//                }
//                .padding(.horizontal, 18)
//                .padding(.vertical, 12)
//            }
//            .padding(.horizontal, 32)
//        }
//    }
//}
//
//#Preview {
//    CircularSelectionTimerView(viewModel: TimerViewModel())
//}



import SwiftUI

struct CircularSelectionTimerView: View {
    @ObservedObject var viewModel: TimerViewModel
    
    let size: CGFloat = 260
    let lineWidth: CGFloat = 14
    
    var body: some View {
        VStack(spacing: 24) {
            
            // MARK: - دائرة التايمر (في النص)
            ZStack {
                Circle()
                    .fill(Color(.systemGray6))
                    .frame(width: size, height: size)
                    .shadow(radius: 4)
                
                Circle()
                    .stroke(Color(.systemGray3), lineWidth: lineWidth)
                    .frame(width: size, height: size)
                
                Circle()
                    .trim(from: 0, to: viewModel.selectionProgress)
                    .stroke(
                        Color(red: 0.02, green: 0.25, blue: 0.49),
                        style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                    )
                    .frame(width: size, height: size)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut(duration: 0.2),
                               value: viewModel.selectionProgress)
                
                Text("\(viewModel.selectedMinutes)m")
                    .font(.system(size: 64, weight: .medium, design: .rounded))
                    .foregroundColor(Color(red: 0.02, green: 0.25, blue: 0.49))
            }
            .onTapGesture {
                viewModel.startFocus()
            }
            
            // MARK: - سلايدر بسيط لتحديد الوقت
//            VStack(alignment: .leading, spacing: 8) {
//                Text("Slide to choose the time")
//                    .font(.system(size: 14, weight: .medium))
//                    .foregroundColor(.white.opacity(0.9))
//                
//                Slider(
//                    value: Binding(
//                        get: { Double(viewModel.selectedMinutes) },
//                        set: { viewModel.updateSelection(minutes: Int($0)) }
//                    ),
//                    in: 1...Double(viewModel.maxMinutes),
//                    step: 1
//                )
//            }
            // MARK: - سلايدر + النص تحت بالنص
            VStack(spacing: 12) {

                // السلايدر
                Slider(
                    value: Binding(
                        get: { Double(viewModel.selectedMinutes) },
                        set: { viewModel.updateSelection(minutes: Int($0)) }
                    ),
                    in: 1...Double(viewModel.maxMinutes),
                    step: 1
                )
                .padding(.horizontal, 40)

                // النص تحت السلايدر *بالنص*
                Text("Slide, then tap the circle")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
            }
            .padding(.top, 8)
            .padding(.horizontal, 40)
        }
    }
}

#Preview {
    CircularSelectionTimerView(viewModel: TimerViewModel())
}
