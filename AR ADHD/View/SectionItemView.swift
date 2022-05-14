//
//  SectionItemView.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/5/10.
//

import SwiftUI

struct SectionItemView: View {
    /*
    @StateObject var questionController = QuestionController()
    @Namespace var namespace
    @State var show = false
    */
    var body: some View {

        VStack(alignment: .leading, spacing: 8.0){
            Spacer()
            Text("SNAP-IV Rating Scale")
                .sectionTitle()
            Text("26 ITEMS  -10MINS")
                .sectionNote()
            Text("The SNAP-IV 26-item scale is an abbreviated version of the Swanson, Nolan, and Pelham (SNAP) Questionnaire (Swanson, 1992; Swanson et al., 1983).")
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .padding(.bottom, 30.0)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.secondary)
            
        }
        .padding(.all, 20)
        .frame(height: 320)
        .padding(.vertical,20)
        .background(.ultraThinMaterial,in:RoundedRectangle(cornerRadius: 40,style:.continuous))
        //.background(.white.opacity(0.3))
        //.mask(RoundedRectangle(cornerRadius: 30,style:.continuous))
        .shadow(color: Color("Shadow").opacity(0.3), radius: 10, x: 0, y: 10)
        .strokeStyles()
        .padding(.horizontal,20)
        .background(Image("purpuleBackground")
                        .resizable(capInsets: EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0), resizingMode: .stretch)
                        .frame(width: 550.0,height: 450.0).offset(x:20,y:-30))
        .overlay(Image("greenHeart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height:230)
                    .offset(x:110,y:-50))
        .overlay(Image("leaves")
                    .resizable()
                    .frame(width:512,height: 400)
                .offset(x:-15,y:45))
    }
}

struct TopicItemView_Previews: PreviewProvider {
    static var previews: some View {
        SectionItemView()
    }
}
