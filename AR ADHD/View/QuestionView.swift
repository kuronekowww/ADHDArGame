//
//  ScaleView.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/4/20.
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var questionController :QuestionController
    //load question

    var body: some View {
        VStack(spacing:20){
            HStack(){
                Text("ADHD Scale")
                    .lilacTitle()
                Spacer()
                
                Text("\(questionController.index + 1) out of \(questionController.length)")
                    .foregroundColor(Color("AccentColor"))
                    .fontWeight(.heavy)
            }
            ProgressBar(questionProgress:questionController.progress)

            VStack(alignment: .leading, spacing: 30.0){
                
                Text(questionController.question)
                    .font(.system(size:20))
                    .bold()
                    .foregroundColor(.gray)
                ForEach(questionController.answerChoices, id:\.id){
                    answer in AnswerRow(answer: answer).environmentObject(questionController)
                }
                /*
                AnswerRow(answer: Answer(text:"Not at all",point: 0))
                    .environmentObject(questionController)
                AnswerRow(answer: Answer(text:"Just a little",point: 1))
                    .environmentObject(questionController)
                AnswerRow(answer: Answer(text:"Quite a bit",point: 2))
                    .environmentObject(questionController)
                AnswerRow(answer: Answer(text:"Very much",point: 3))
                    .environmentObject(questionController)
                 */
            }
            Button{
                questionController.goToNextQuestion()
            }label:{
            PrimaryButton(text:"Next",background: questionController.answerSelected ? .accentColor: .gray)
                    .disabled(!questionController.answerSelected)

            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BackgroundColor"))
        .navigationBarHidden(true)
    }
    
}

struct ScaleView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView().environmentObject(QuestionController())
    }
}
