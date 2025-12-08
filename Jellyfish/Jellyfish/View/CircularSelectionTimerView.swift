

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
