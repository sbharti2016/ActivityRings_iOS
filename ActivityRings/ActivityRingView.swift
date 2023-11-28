//
//  ActivityRingView.swift
//  ActivityRings
//
//  Created by Sanjeev Bharti on 11/27/23.
//

import SwiftUI

struct ActivityRingView: View {
    
    @State private var percentage = 0.0
    private let height: CGFloat
    private let lightColor: Color
    private let darkColor: Color
    private let darkerColor: Color
    
    init(percentage: Double = 0.0, height: CGFloat = 300.0, lightColor: Color = .lightBlue, darkColor: Color = .darkBlue, darkerColor: Color = .darkerBlue) {
        self.percentage = percentage
        self.height = height
        self.lightColor = lightColor
        self.darkColor = darkColor
        self.darkerColor = darkerColor
    }
    
    var body: some View {
        
        ZStack {
            
            ZStack {
                
                Circle()
                    .stroke(lightColor.opacity(0.2), lineWidth: 30.0)
                
                Circle()
                    .trim(from: 0.0, to: percentage <= 1 ? percentage : 1.0)
                    .stroke(Color.angularGradiantFrom(finalColors: [lightColor, darkColor]), style: .init(lineWidth: 30.0, lineCap: .round, lineJoin: .round))
                    .rotationEffect(.degrees(-90.0))
                
                Circle()
                    .fill(percentage > 0.99 ? darkColor : lightColor)
                    .frame(height: 30.0)
                    .offset(y: -height/2)
                
                Circle()
                    .trim(from: 0.0, to: percentage > 1.0 ? percentage - 1.0 : 0.0)
                    .stroke(Color.angularGradiantFrom(finalColors: [darkColor, darkerColor]), style: .init(lineWidth: 30.0, lineCap: .round))
                    .rotationEffect(.degrees(-90.0))
            }
            .animation(.bouncy(duration: 5.0), value: percentage)

            Circle()
                .fill(percentage > 1.0 ? darkColor : .clear)
                .frame(height: 30.0)
                .offset(y: -height/2)
                .animation(.easeIn(duration: 0.1), value: percentage)
        }
        .frame(height: height)
        .onAppear(perform: {
            percentage = 1.3
        })
        .onTapGesture() {
            percentage += 0.2
        }
    }
}

#Preview {
    
    ZStack {
        ActivityRingView(height: 150, lightColor: .lightBlue, darkColor: .darkerBlue, darkerColor: .black)
        ActivityRingView(height: 250, lightColor: .lightRed, darkColor: .darkerRed, darkerColor: .black)
        ActivityRingView(height: 350, lightColor: .lightGreen, darkColor: .darkerGreen, darkerColor: .black)
    }
    
}

extension Color {

    static var angularGradiant: AngularGradient {
        return AngularGradient(gradient: Gradient(colors: [.white, .red]), center: .center)
    }
    
    static func angularGradiantFrom(finalColors: [Color]) -> AngularGradient {
        return AngularGradient(gradient: Gradient(colors: finalColors), center: .center)
    }
    
}
