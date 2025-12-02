
import SwiftUI

struct CircularSelectionTimerView: View {
    @ObservedObject var viewModel: TimerViewModel
    
    let size: CGFloat = 260
    let lineWidth: CGFloat = 14
    
    var body: some View {
        VStack(spacing: 24) {
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
                    .animation(.easeInOut(duration: 0.15),
                               value: viewModel.selectionProgress)
                
                Text("\(viewModel.selectedSeconds)")
                    .font(.system(size: 64,
                                  weight: .medium,
                                  design: .rounded))
                    .foregroundColor(Color(red: 0.02,
                                           green: 0.25,
                                           blue: 0.49))
            }
            .onTapGesture {
                // لما يضغط على الدائرة: نبدأ التايمر ونروح للجلي فِش
                viewModel.startFocus()
            }
            
            // مؤقتًا: اختيار الوقت بسلايدر (من 1 إلى 120 ثانية)
            VStack(spacing: 8) {
                Slider(
                    value: Binding(
                        get: { Double(viewModel.selectedSeconds) },
                        set: { viewModel.updateSelection(seconds: Int($0)) }
                    ),
                    in: 1...Double(viewModel.maxSeconds),
                    step: 1
                )
                .padding(.horizontal, 32)
                
                Text("Slide to choose the time, then tap the circle")
                    .foregroundColor(.white)
                    .font(.system(size: 15, weight: .medium))
            }
        }
    }
}
