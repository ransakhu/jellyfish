//
//import SwiftUI
//
//struct WaveShape: Shape {
//    var phase: CGFloat
//    var amplitude: CGFloat
//    
//    var animatableData: CGFloat {
//        get { phase }
//        set { phase = newValue }
//    }
//    
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        let width = rect.width
//        let height = rect.height
//        let midHeight = height * 0.5
//        let wavelength = width / 1.2
//        
//        path.move(to: CGPoint(x: 0, y: midHeight))
//        
//        stride(from: 0, through: width, by: 1).forEach { x in
//            let relativeX = x / wavelength
//            let sine = sin(relativeX * .pi * 2 + phase)
//            let y = midHeight + sine * amplitude
//            path.addLine(to: CGPoint(x: x, y: y))
//        }
//        
//        path.addLine(to: CGPoint(x: width, y: height))
//        path.addLine(to: CGPoint(x: 0, y: height))
//        path.closeSubpath()
//        return path
//    }
//}
//
//struct SeaBackground: View {
//    @State private var phase1: CGFloat = 0
//    @State private var phase2: CGFloat = 0
//    @State private var phase3: CGFloat = 0
//    
//    var body: some View {
//        ZStack {
//            Color(red: 0.31, green: 0.58, blue: 0.86)
//            
//            WaveShape(phase: phase1, amplitude: 20)
//                .fill(Color(red: 0.24, green: 0.53, blue: 0.86))
//                .offset(y: 80)
//                .opacity(0.8)
//            
//            WaveShape(phase: phase2, amplitude: 25)
//                .fill(Color(red: 0.13, green: 0.41, blue: 0.79))
//                .offset(y: 160)
//                .opacity(0.9)
//            
//            WaveShape(phase: phase3, amplitude: 30)
//                .fill(Color(red: 0.05, green: 0.27, blue: 0.62))
//                .offset(y: 240)
//        }
//        .ignoresSafeArea()
//        .onAppear {
//            withAnimation(.linear(duration: 6).repeatForever(autoreverses: false)) {
//                phase1 = .pi * 2
//            }
//            withAnimation(.linear(duration: 8).repeatForever(autoreverses: false)) {
//                phase2 = .pi * 2
//            }
//            withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
//                phase3 = .pi * 2
//            }
//        }
//    }
//}







//import SwiftUI
//
//struct WaveShape: Shape {
//    var phase: CGFloat
//    var amplitude: CGFloat
//    
//    var animatableData: CGFloat {
//        get { phase }
//        set { phase = newValue }
//    }
//    
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        let width = rect.width
//        let height = rect.height
//        let midHeight = height * 0.5
//        let wavelength = width / 1.2
//        
//        path.move(to: CGPoint(x: 0, y: midHeight))
//        
//        stride(from: 0, through: width, by: 1).forEach { x in
//            let relativeX = x / wavelength
//            let sine = sin(relativeX * .pi * 2 + phase)
//            let y = midHeight + sine * amplitude
//            path.addLine(to: CGPoint(x: x, y: y))
//        }
//        
//        path.addLine(to: CGPoint(x: width, y: height))
//        path.addLine(to: CGPoint(x: 0, y: height))
//        path.closeSubpath()
//        return path
//    }
//}
//
//struct SeaBackground: View {
//    @State private var phase1: CGFloat = 0
//    @State private var phase2: CGFloat = 0
//    @State private var phase3: CGFloat = 0
//    @State private var phase4: CGFloat = 0
//    @State private var phase5: CGFloat = 0
//    @State private var phase6: CGFloat = 0
//    
//    var body: some View {
//        ZStack {
//            // السماء
//            Color(red: 0.31, green: 0.58, blue: 0.86)
//                .ignoresSafeArea()
//            
//            // ٦ طبقات أمواج – مرفوعة لفوق شوية
//            WaveShape(phase: phase1, amplitude: 20)
//                .fill(Color(red: 0.53, green: 0.74, blue: 0.93))
//                .offset(y: -40)
//                .opacity(0.8)
//            
//            WaveShape(phase: phase2, amplitude: 22)
//                .fill(Color(red: 0.37, green: 0.64, blue: 0.92))
//                .offset(y: 20)
//                .opacity(0.9)
//            
//            WaveShape(phase: phase3, amplitude: 24)
//                .fill(Color(red: 0.23, green: 0.54, blue: 0.88))
//                .offset(y: 80)
//            
//            WaveShape(phase: phase4, amplitude: 26)
//                .fill(Color(red: 0.16, green: 0.47, blue: 0.82))
//                .offset(y: 140)
//            
//            WaveShape(phase: phase5, amplitude: 28)
//                .fill(Color(red: 0.09, green: 0.37, blue: 0.76))
//                .offset(y: 200)
//            
//            WaveShape(phase: phase6, amplitude: 30)
//                .fill(Color(red: 0.04, green: 0.29, blue: 0.68))
//                .offset(y: 260)
//        }
//        .onAppear {
//            withAnimation(.linear(duration: 6).repeatForever(autoreverses: false)) {
//                phase1 = .pi * 2
//            }
//            withAnimation(.linear(duration: 7).repeatForever(autoreverses: false)) {
//                phase2 = .pi * 2
//            }
//            withAnimation(.linear(duration: 8).repeatForever(autoreverses: false)) {
//                phase3 = .pi * 2
//            }
//            withAnimation(.linear(duration: 9).repeatForever(autoreverses: false)) {
//                phase4 = .pi * 2
//            }
//            withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
//                phase5 = .pi * 2
//            }
//            withAnimation(.linear(duration: 11).repeatForever(autoreverses: false)) {
//                phase6 = .pi * 2
//            }
//        }
//    }
//}



import SwiftUI

struct WaveShape: Shape {
    var phase: CGFloat
    var amplitude: CGFloat
    
    var animatableData: CGFloat {
        get { phase }
        set { phase = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        let midHeight = height * 0.55      // نرفع مركز الموجة شوي
        let wavelength = width / 1.3       // نطوّل الموجة
        
        path.move(to: CGPoint(x: 0, y: midHeight))
        
        stride(from: 0, through: width, by: 1).forEach { x in
            let relativeX = x / wavelength
            let sine = sin(relativeX * .pi * 2 + phase)
            let y = midHeight + sine * amplitude
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()
        return path
    }
}

struct SeaBackground: View {
    @State private var phase1: CGFloat = 0
    @State private var phase2: CGFloat = 0
    @State private var phase3: CGFloat = 0
    @State private var phase4: CGFloat = 0
    @State private var phase5: CGFloat = 0
    @State private var phase6: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color(red: 0.31, green: 0.58, blue: 0.86)
                .ignoresSafeArea()
            
            // أعلى موجة – كبيرة ومرتفعة
            WaveShape(phase: phase1, amplitude: 34)
                .fill(Color(red: 0.55, green: 0.76, blue: 0.94))
                .offset(y: -140)
                .opacity(0.85)
            
            // الموجة الثانية – أصغر شوي وتحتها
            WaveShape(phase: phase2, amplitude: 28)
                .fill(Color(red: 0.42, green: 0.68, blue: 0.93))
                .offset(y: -60)
                .opacity(0.9)
            
            // الموجة الثالثة
            WaveShape(phase: phase3, amplitude: 24)
                .fill(Color(red: 0.30, green: 0.60, blue: 0.90))
                .offset(y: 20)
            
            // الموجة الرابعة
            WaveShape(phase: phase4, amplitude: 26)
                .fill(Color(red: 0.21, green: 0.52, blue: 0.85))
                .offset(y: 110)
            
            // الموجة الخامسة
            WaveShape(phase: phase5, amplitude: 30)
                .fill(Color(red: 0.13, green: 0.42, blue: 0.78))
                .offset(y: 200)
            
            // أعمق موجة – كبيرة وغامقة تحت
            WaveShape(phase: phase6, amplitude: 36)
                .fill(Color(red: 0.06, green: 0.30, blue: 0.66))
                .offset(y: 290)
        }
        .onAppear {
            // نخلّي الأمواج تمشي في اتجاهات مختلفة وسرعات مختلفة
            withAnimation(.linear(duration: 7).repeatForever(autoreverses: false)) {
                phase1 = .pi * 2          // اتجاه 1
            }
            withAnimation(.linear(duration: 9).repeatForever(autoreverses: false)) {
                phase2 = -.pi * 2         // عكس الاتجاه
            }
            withAnimation(.linear(duration: 8).repeatForever(autoreverses: false)) {
                phase3 = .pi * 2
            }
            withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
                phase4 = -.pi * 2
            }
            withAnimation(.linear(duration: 11).repeatForever(autoreverses: false)) {
                phase5 = .pi * 2
            }
            withAnimation(.linear(duration: 13).repeatForever(autoreverses: false)) {
                phase6 = -.pi * 2
            }
        }
    }
}
