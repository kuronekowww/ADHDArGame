//
//  IntroductionView.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/5/12.
//

import SwiftUI

struct IntroductionView: View {
    var namespace: Namespace.ID
    @Binding var show: Bool
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(
            Image("starBackground")
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
                    Text("ADHD rating scales are an essential tool for diagnosis, evaluation and monitoring of the symptoms of attention deficit hyperactivity disorder in children.")
                        .font(.body)

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
            Button{
                withAnimation(.spring(response:0.6, dampingFraction: 0.8)){
                    show.toggle()
                }
            }label:{
                Image(systemName: "xmark")
                    .font(.body.weight(.bold))
                    .foregroundColor(.secondary)
                    .padding(8)
                    .background(.ultraThinMaterial,in: Circle())
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(20)
            //.ignoresSafeArea()
        }
    }
}

struct IntroductionView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        IntroductionView(namespace: namespace, show: .constant(true))
    }
}
