//
//  RatingScaleView.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/4/21.
//

import SwiftUI

struct RatingScaleView: View {
    @EnvironmentObject var questionController :QuestionController
    var body: some View {
        
        if questionController.reachedEnd{
          
            ScaleResultView().environmentObject(questionController)

        }else{
        QuestionView().environmentObject(questionController)
    }
    }
}

struct RatingScaleView_Previews: PreviewProvider {
    static var previews: some View {
        RatingScaleView()
            .environmentObject(QuestionController())
    }
}
