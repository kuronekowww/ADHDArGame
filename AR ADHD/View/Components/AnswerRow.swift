//
//  AnswerRow.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/4/21.
//

import SwiftUI

struct AnswerRow: View {
    @EnvironmentObject var questionController :QuestionController
    @State public var isSelected = false
    
    var answer: Answer
    var body: some View {
        
        HStack(spacing:20){
            Image(systemName: "circle.fill")
                .font(.caption)
            
            Text(answer.text)
                .bold()
            /*
            if isSelected{
                Spacer()
                
                Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)            }
            */
        }
        .padding()
        .frame(maxWidth:.infinity,alignment: .leading)
        .foregroundColor(questionController.answerSelected ?(isSelected ?.accentColor : .gray) : .accentColor)
        .background(.white)
        .cornerRadius(10)
        .shadow(color: isSelected ? .accentColor : .gray, radius: 5, x: 0.5, y: 0.5)
        .onTapGesture {
            if !questionController.answerSelected{
                isSelected=true
                questionController.selectedAnswer(answer: answer)
            }
        }
    }
}

struct AnswerRow_Previews: PreviewProvider {
    static var previews: some View {
        AnswerRow(answer: Answer(text: "single", point: 1))
            .environmentObject(QuestionController())
    }
}
