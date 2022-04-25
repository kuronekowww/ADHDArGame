//
//  ScaleResultView.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/4/25.
//

import SwiftUI

struct ScaleResultView: View {
    @EnvironmentObject var questionController :QuestionController
    
    var body: some View {
        VStack(spacing: 20){
           Text("Scale")
                .lilacTitle()
            Text("Completed")
            
            Text("Score1:\(questionController.subsetScore1)")
            Text("Score2:\(questionController.subsetScore2)")
            Button{
                
            }label:{
                PrimaryButton(text:"back")
            }
        }
        .foregroundColor(.accentColor)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BackgroundColor"))
    }
}

struct ScaleResultView_Previews: PreviewProvider {
    static var previews: some View {
        ScaleResultView()
    }
}