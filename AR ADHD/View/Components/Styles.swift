//
//  Styles.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/5/9.
//

import SwiftUI

struct StrokeStyles: ViewModifier {
    var cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content.overlay(
            RoundedRectangle(cornerRadius: cornerRadius,style: .continuous)
                .stroke(
                    .linearGradient(colors:[.white.opacity(0.3),.black.opacity(0.1)],
                                    startPoint:.top,endPoint:.bottom))
                .blendMode(.overlay)
        )
    }
}

extension View{
    func strokeStyles(cornerRadius: CGFloat = 30) -> some View{
        modifier(StrokeStyles(cornerRadius: cornerRadius))
    }
}
