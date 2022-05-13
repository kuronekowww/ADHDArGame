//
//  MatchedView.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/5/12.
//

import SwiftUI

struct MatchedView: View {
    @Namespace var namespace
    @State var show = false
    
    var body: some View {
        ZStack{
            
            if !show{
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
            }else{
                VStack {
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .background(
                Image("StarBackground")
                    .matchedGeometryEffect(id: "background", in: namespace))
                .mask(RoundedRectangle(cornerRadius: 20,style: .continuous)
                .matchedGeometryEffect(id: "mask", in: namespace))
                .ignoresSafeArea(.all)
                .overlay(
                    VStack(alignment: .leading, spacing: 12) {
                        Text("my ADHD scale")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .matchedGeometryEffect(id: "title", in: namespace)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        Text("The SNAP-IV 26-item scale is an abbreviated version of the Swanson, Nolan, and Pelham (SNAP) Questionnaire (Swanson, 1992; Swanson et al., 1983). Items from the DSM-IV criteria for attention-deficit/hyperactivity disorder (ADHD) are included for the two subsets of symptoms: Inattention (items 1–9) and Hyperactivity/Impulsivity (items 10– 18). Also, items from the DSM-IV criteria for oppositional defiant disorder (ODD) are included (items 19–26) because ODD is often present in children wit")
                            .font(.body)
                        
                    }
                    .padding(20)
                    .foregroundColor(.primary)
                    .background(
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .mask(RoundedRectangle(cornerRadius: 20,style: .continuous))
                            .matchedGeometryEffect(id: "blur", in: namespace))
                        .offset(y:-100)
                        .padding(10)
                )
            }
        }
        .onTapGesture {
            withAnimation(.spring(response:0.6,dampingFraction: 0.8)){
                show.toggle()
            }
        }
    }
}

struct MatchedView_Previews: PreviewProvider {
    static var previews: some View {
        MatchedView()
    }
}
