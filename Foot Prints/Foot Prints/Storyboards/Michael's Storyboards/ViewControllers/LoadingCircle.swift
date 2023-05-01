//
//  LoadingCircle.swift
//  Foot Prints
//
//  Created by Michael Whiting on 5/1/23.
//

import SwiftUI

extension Animation {
    public static var rotateAnimation: Animation {
        Animation.linear(duration: 1)
            .repeatForever(autoreverses: false)
    }
    
    public static var rotateAnimationFast: Animation {
        Animation.linear(duration: 0.75)
            .repeatForever(autoreverses: false)
    }
}

struct CustomLoadCircle: View {
    @State var isRotating: Bool = false
    @State var isRotatingFast: Bool = false
    
    var isLoading: Bool
    
    var body: some View {
        if isLoading {
            ZStack {
                Circle()
                    .trim(from: 0.08, to: 0.18)
                    .stroke(Color.blue.opacity(0.8), style: StrokeStyle(lineWidth: 5))
                    .frame(width: 30, height: 30)
                    .rotationEffect(Angle.degrees(isRotatingFast ? 360 : 0))
                Circle()
                    .trim(from: 0.23, to: 0.33)
                    .stroke(Color.blue.opacity(0.8), style: StrokeStyle(lineWidth: 5))
                    .frame(width: 30, height: 30)
                    .rotationEffect(Angle.degrees(isRotatingFast ? 360 : 0))
                Circle()
                    .trim(from: 0.38, to: 0.48)
                    .stroke(Color.blue.opacity(0.8), style: StrokeStyle(lineWidth: 5))
                    .frame(width: 30, height: 30)
                    .rotationEffect(Angle.degrees(isRotatingFast ? 360 : 0))
                Circle()
                    .trim(from: 0.60, to: 1)
                    .stroke(Color.blue.opacity(0.8), style: StrokeStyle(lineWidth: 5))
                    .frame(width: 30, height: 30)
                    .rotationEffect(Angle.degrees(isRotating ? 360 : 0))
            }
            .onAppear {
                withAnimation(Animation.rotateAnimation) {
                    isRotating = true
                }
                withAnimation(Animation.rotateAnimationFast) {
                    isRotatingFast = true
                }
            }
        }
    }
}

//struct LoadingCircle_Previews: PreviewProvider {
//    static var previews: some View {
//        LoadingCircle()
//    }
//}
