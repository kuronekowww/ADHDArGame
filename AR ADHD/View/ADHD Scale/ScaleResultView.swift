//
//  ScaleResultView.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/4/25.
//

import SwiftUI

struct ScaleResultView: View {
    @EnvironmentObject var questionController : QuestionController
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 20){
            VStack(spacing:20){

            VStack {
    
                Text("Inattention Subset")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.accentColor)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth:.infinity,alignment: .leading)
                HStack(spacing:40) {
                    Text("Score: \(questionController.subsetScore1)")
                        .font(.title2)
                        .fontWeight(.light)
                        .foregroundColor(.indigo).multilineTextAlignment(.center)
                        .padding(.top, 2)
                    Text("Rate:\(questionController.subsetRate1)")
                        .font(.title2)
                        .fontWeight(.light)
                        .foregroundColor(.indigo).multilineTextAlignment(.center)
                        .padding(.top, 2)
                }
            }
            .padding(10)
            .frame(maxWidth:.infinity,alignment: .leading)
            .frame(height:150)
            .background(.white.opacity(0.4))
            .cornerRadius(20)
            .shadow(color: Color("Shadow").opacity(0.2), radius: 20, x: 0, y: 4)
            VStack {
                Text("Hyperactivity/Impulsivity Subset")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.accentColor)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth:.infinity,alignment: .leading)
                HStack(spacing:40) {
                    Text("Score: \(questionController.subsetScore2)")
                        .font(.title2)
                        .fontWeight(.light)
                        .foregroundColor(.indigo)
                        .padding(.top, 2)
                    Text("Rate:\(questionController.subsetRate2)")
                        .font(.title2)
                        .fontWeight(.light)
                        .foregroundColor(.indigo)
                        .padding(.top, 2)
                }
            }
            .padding(10)
            .frame(maxWidth:.infinity,alignment: .leading)
            .frame(height:150)
            .background(.white.opacity(0.4))
            .cornerRadius(20)
            .shadow(color: Color("Shadow").opacity(0.2), radius: 20, x: 0, y: 4)
            VStack {
                Text("Opposition/Defiance Subset")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.accentColor)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth:.infinity,alignment: .leading)
                HStack(spacing:40) {
                    Text("Score: \(questionController.subsetScore3)")
                        .font(.title2)
                        .fontWeight(.light)
                        .foregroundColor(.indigo).multilineTextAlignment(.center)
                        .padding(.top, 2)
                    Text("Rate:\(questionController.subsetRate3)")
                        .font(.title2)
                        .fontWeight(.light)
                        .foregroundColor(.indigo).multilineTextAlignment(.center)
                        .padding(.top, 2)
                }
            }
            .padding(10)
            .frame(maxWidth:.infinity,alignment: .leading)
            .frame(height:150)
            .background(.white.opacity(0.4))
            .cornerRadius(20)
            .shadow(color: Color("Shadow").opacity(0.2), radius: 20, x: 0, y: 4)
            }
            VStack {
                Text("Symptom severity is rated on a 4-point scale. Responses are scored as follows:")
                Text("Not at all = 0")
                Text("Just a little = 1")
                Text("Quite a bit = 2")
                Text("Very much = 3")
                }
            .font(.footnote)
            .foregroundColor(.secondary)
            .frame(maxWidth:.infinity, alignment: .center)
            .padding(.top, 5)
            Spacer()


        }
        .padding(.top, 100)
        .padding(16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Image("scaleBackground"))
        .overlay(
            NavigationBar(title: "Scale Result")
                .foregroundColor(.secondary)
                .offset(y:30)
        ).ignoresSafeArea()
    }
}

struct ScaleResultView_Previews: PreviewProvider {
    static var previews: some View {
        ScaleResultView().environmentObject(QuestionController())
    }
}
