//
//  IntroductionItem.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/5/12.
//

import SwiftUI

struct IntroductionItem: View {
    var namespace: Namespace.ID
    @Binding var show: Bool
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 12) {
                Text("Know about ADHD")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .matchedGeometryEffect(id: "title", in: namespace)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                Text("check mine scale")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
            }
            .padding(20)
            .background(Rectangle().fill(.white.opacity(0))
                            .mask(RoundedRectangle(cornerRadius: 20,style: .continuous))
                            .blur(radius: 0)
                            .matchedGeometryEffect(id: "blur", in: namespace))
        }
        .background(
                Image("darkSection").matchedGeometryEffect(id: "background", in: namespace))
        .frame(height:100)
        .cornerRadius(20)
    .padding(25)
    }
}

struct IntroductionItem_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        IntroductionItem(namespace:namespace,show: .constant(true))
    }
}
