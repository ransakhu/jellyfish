//import SwiftUI
//
//struct JellyfishFocusView: View {
//    @ObservedObject var viewModel: TimerViewModel
//    @State private var floatUp = false
//     @State private var wiggle = false
//    var body: some View {
//        VStack(spacing: 16) {
//            Spacer()
//            
//                      Image("Jellyfish")
//                          .resizable()
//                          .scaledToFit()
//                          .frame(width: 220, height: 220)
//                          // تطفو فوق وتحت
//                          .offset(y: floatUp ? -12 : 12)
//                          // تميل يمين ويسار
//                          .rotationEffect(.degrees(wiggle ? 4 : -4))
//                          // تمدد عمودي بسيط يخليها كأنها تنفش وتنكمش
//                          .scaleEffect(x: 1,
//                                       y: wiggle ? 1.05 : 0.95,
//                                       anchor: .top)
//                          .shadow(radius: 10)
//                          .onAppear {
//                              // حركة الطفو
//                              withAnimation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true)) {
//                                  floatUp.toggle()
//                              }
//                              // حركة التموج / رجولها يمين يسار
//                              withAnimation(.easeInOut(duration: 0.9).repeatForever(autoreverses: true)) {
//                                  wiggle.toggle()
//                              }
//                          }
//                      
//                      // 👇 خليه زي ما هو عندك
//                      Text("keep the fish alive!")
//                          .foregroundColor(.white)
//                          .font(.system(size: 20, weight: .semibold))
//                      
//                      Text("\(viewModel.remainingSeconds) s left")
//                          .foregroundColor(.white.opacity(0.9))
//                          .font(.system(size: 16))
//            
//            Text("keep the fish alive!")
//                .foregroundColor(.white)
//                .font(.system(size: 20, weight: .semibold))
//            
//            Text("\(viewModel.remainingSeconds) s left")
//                .foregroundColor(.white.opacity(0.9))
//                .font(.system(size: 16))
//            
//            // أثناء التشغيل (RUNNING)
//            if viewModel.mode == .running {
//                HStack(spacing: 16) {
//                    
//                    // PAUSE / RESUME
//                    Button(action: {
//                        viewModel.togglePause()
//                    }) {
//                        Text(viewModel.isPaused ? "Resume" : "Pause")
//                            .padding(.horizontal, 24)
//                            .padding(.vertical, 10)
//                            .background(Color.white.opacity(0.2))
//                            .foregroundColor(.white)
//                            .cornerRadius(20)
//                    }
//                    
//                    // STOP
//                    Button(action: {
//                        viewModel.reset()
//                    }) {
//                        Text("Stop")
//                            .padding(.horizontal, 24)
//                            .padding(.vertical, 10)
//                            .background(Color.white)
//                            .foregroundColor(Color(red: 0.02, green: 0.25, blue: 0.49))
//                            .cornerRadius(20)
//                    }
//                }
//                .padding(.top, 8)
//            }
//            
//            // بعد ما يخلص الوقت (FINISHED)
//            if viewModel.mode == .finished {
//                Text("Nice focus time! 🎉")
//                    .foregroundColor(.white)
//                    .font(.system(size: 18, weight: .bold))
//                    .padding(.top, 8)
//                
//                Button(action: {
//                    viewModel.reset()
//                }) {
//                    Text("Start again")
//                        .padding(.horizontal, 24)
//                        .padding(.vertical, 10)
//                        .background(Color.white)
//                        .foregroundColor(Color(red: 0.02, green: 0.25, blue: 0.49))
//                        .cornerRadius(20)
//                }
//                .padding(.top, 8)
//            }
//            
//            Spacer().frame(height: 40)
//        }
//        .padding(.horizontal, 16)
//    }
//}
//
//#Preview {
//    JellyfishFocusView(viewModel: TimerViewModel())
//}
import SwiftUI

struct JellyfishFocusView: View {
    @ObservedObject var viewModel: TimerViewModel
    
    // أنيميشن الجيلي فِش
    @State private var floatUp = false
    @State private var wiggle = false
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            
            // صورة الجيلي فِش المتحركة
            Image("Jellyfish")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
                .offset(y: floatUp ? -12 : 12)               // تطفو فوق وتحت
                .rotationEffect(.degrees(wiggle ? 4 : -4))   // تميل يمين ويسار
                .scaleEffect(x: 1,
                             y: wiggle ? 1.05 : 0.95,
                             anchor: .top)                   // تمدد بسيط
                .shadow(radius: 10)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true)) {
                        floatUp.toggle()
                    }
                    withAnimation(.easeInOut(duration: 0.9).repeatForever(autoreverses: true)) {
                        wiggle.toggle()
                    }
                }
            // أثناء التشغيل
            if viewModel.mode == .running {
                Text("keep the fish alive!")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .semibold))
                
                // هنا نعرض 03:00 ، 02:59 ، ...
                Text(viewModel.formattedTime(viewModel.remainingSeconds))
                    .foregroundColor(.white.opacity(0.9))
                    .font(.system(size: 16))
            }
            // 🟦 أثناء التشغيل فقط (RUNNING)
//            if viewModel.mode == .running {
//                Text("keep the fish alive!")
//                    .foregroundColor(.white)
//                    .font(.system(size: 20, weight: .semibold))
//                
//                Text("\(viewModel.remainingSeconds) s left")
//                    .foregroundColor(.white.opacity(0.9))
//                    .font(.system(size: 16))
//            }
            
            // 🟩 بعد ما يخلص (FINISHED)
            if viewModel.mode == .finished {
                Text("Nice focus time! 🎉")
                    .foregroundColor(.white)
                    .font(.system(size: 22, weight: .bold))
                    .padding(.top, 8)
            }
            
            // أزرار أثناء التشغيل (Pause / Stop)
            if viewModel.mode == .running {
                HStack(spacing: 16) {
                    // PAUSE / RESUME
                    Button(action: {
                        viewModel.togglePause()
                    }) {
                        Text(viewModel.isPaused ? "Resume" : "Pause")
                            .padding(.horizontal, 24)
                            .padding(.vertical, 10)
                            .background(Color.white.opacity(0.2))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                    
                    // STOP (يرجع لشاشة اختيار الوقت)
                    Button(action: {
                        viewModel.reset()
                    }) {
                        Text("Stop")
                            .padding(.horizontal, 24)
                            .padding(.vertical, 10)
                            .background(Color.white)
                            .foregroundColor(Color(red: 0.02, green: 0.25, blue: 0.49))
                            .cornerRadius(20)
                    }
                }
                .padding(.top, 8)
            }
            
            // زر بعد ما يخلص الوقت
            if viewModel.mode == .finished {
                Button(action: {
                    viewModel.reset()
                }) {
                    Text("Start again")
                        .padding(.horizontal, 24)
                        .padding(.vertical, 10)
                        .background(Color.white)
                        .foregroundColor(Color(red: 0.02, green: 0.25, blue: 0.49))
                        .cornerRadius(20)
                }
                .padding(.top, 8)
            }
            
            Spacer().frame(height: 40)
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    JellyfishFocusView(viewModel: TimerViewModel())
}
