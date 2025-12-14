//
//  splashscreen.swift
//  Jellyfish
//
//  Created by ريناد محمد حملي on 23/06/1447 AH.
//




import Foundation
import SwiftUI

struct SplashScreen: View {
    @State private var waveOffset1: CGFloat = 0
    @State private var waveOffset2: CGFloat = 0
    @State private var waveOffset3: CGFloat = 0
    @State private var waveOffset4: CGFloat = 0
    @State private var progress: CGFloat = 0.0
    @State private var isActive = false  // ← أضف هذا السطر
    
    var body: some View {
        if isActive {
            ContentView()  // ← صفحة صديقتك
        } else {
            GeometryReader { geometry in
                ZStack {
                    // الخلفية
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.53, green: 0.75, blue: 0.91),
                            Color(red: 0.40, green: 0.65, blue: 0.85)
                        ]),
                        startPoint: .top,
                        endPoint: .center
                    )
                    .ignoresSafeArea()
                    
                    // الأمواج
                    ZStack {
                        ReactWave(offset: waveOffset1, amplitude: 60, frequency: 0.015, yPos: geometry.size.height * 0.25)
                            .fill(Color(red: 0.45, green: 0.68, blue: 0.88).opacity(0.4))
                        
                        ReactWave(offset: waveOffset2, amplitude: 80, frequency: 0.012, yPos: geometry.size.height * 0.45)
                            .fill(Color(red: 0.35, green: 0.58, blue: 0.82).opacity(0.5))
                        
                        ReactWave(offset: waveOffset3, amplitude: 100, frequency: 0.01, yPos: geometry.size.height * 0.65)
                            .fill(Color(red: 0.20, green: 0.45, blue: 0.75).opacity(0.6))
                        
                        ReactWave(offset: waveOffset4, amplitude: 120, frequency: 0.008, yPos: geometry.size.height * 0.8)
                            .fill(Color(red: 0.15, green: 0.40, blue: 0.70).opacity(0.8))
                    }
                    
                    // البروجرس بار
                    VStack {
                        ZStack {
                            // الحلقة الخلفية
                            Circle()
                                .stroke(Color.white.opacity(0.3), lineWidth: 12)
                                .frame(width: 256, height: 256)
                            
                            // حلقة التقدم
                            Circle()
                                .trim(from: 0, to: progress)
                                .stroke(Color(red: 0.15, green: 0.39, blue: 0.92), style: StrokeStyle(lineWidth: 12, lineCap: .round))
                                .frame(width: 256, height: 256)
                                .rotationEffect(.degrees(-90))
                                .animation(.easeInOut(duration: 0.3), value: progress)
                            
                            // الدائرة البيضاء
                            ZStack {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 210, height: 210)
                                    .shadow(color: .black.opacity(0.8), radius: 0)
                                
                                if progress == 1 {
                                    // شكل الأيقون الصحيح - محسّن
                                    VStack(alignment: .center, spacing: 18) {
                                        // السطر الأول مع الصح
                                        HStack(spacing: 12) {
                                            // المربع الأزرق مع الصح
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(Color(red: 0.25, green: 0.47, blue: 0.85))
                                                    .frame(width: 32, height: 32)
                                                
                                                Image(systemName: "checkmark")
                                                    .font(.system(size: 18, weight: .bold))
                                                    .foregroundColor(.white)
                                            }
                                            
                                            // الخط الطويل - متوازن
                                            Capsule()
                                                .fill(Color(red: 0.68, green: 0.81, blue: 0.93))
                                                .frame(width: 120, height: 12)
                                        }
                                        
                                        // السطر الثاني - متوازن
                                        HStack(spacing: 12) {
                                            // المربع الفارغ للحفاظ على التوازن
                                            RoundedRectangle(cornerRadius: 6)
                                                .fill(Color.clear)
                                                .frame(width: 32, height: 32)
                                            
                                            Capsule()
                                                .fill(Color(red: 0.68, green: 0.81, blue: 0.93))
                                                .frame(width: 100, height: 12)
                                        }
                                        
                                        // السطر الثالث - متوازن وأقصر
                                        HStack(spacing: 12) {
                                            // المربع الفارغ للحفاظ على التوازن
                                            RoundedRectangle(cornerRadius: 6)
                                                .fill(Color.clear)
                                                .frame(width: 32, height: 32)
                                            
                                            Capsule()
                                                .fill(Color(red: 0.68, green: 0.81, blue: 0.93))
                                                .frame(width: 80, height: 12)
                                        }
                                    }
                                    .padding(.horizontal, 20)
                                    .frame(width: 180, height: 180)
                                } else {
                                    Text("\(Int(progress * 100))%")
                                        .font(.system(size: 48, weight: .bold))
                                        .foregroundColor(Color(red: 0.15, green: 0.39, blue: 0.92))
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                // تحريك الأمواج
                Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { _ in
                    waveOffset1 += 0.8
                    waveOffset2 += 1.2
                    waveOffset3 += 0.6
                    waveOffset4 += 0.4
                }
                
                // التحميل: 0 → 10 → 50 → 100
                progress = 0
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation { progress = 0.1 }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation { progress = 0.5 }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation { progress = 1.0 }
                }
                
                // ← أضف هذا: بعد ثانية ونص من وصول 100%، انتقل للصفحة التانية
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

struct ReactWave: Shape {
    var offset: CGFloat
    var amplitude: CGFloat
    var frequency: CGFloat
    var yPos: CGFloat
    
    var animatableData: CGFloat {
        get { offset }
        set { offset = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: yPos))
        
        for x in stride(from: 0, through: rect.width, by: 5) {
            let y = yPos + sin((x + offset) * frequency) * amplitude
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        path.addLine(to: CGPoint(x: rect.width, y: rect.height+100))
        path.addLine(to: CGPoint(x: 0, y: rect.height+100))
        path.closeSubpath()
        return path
    }
}

#Preview {
    SplashScreen()
}
