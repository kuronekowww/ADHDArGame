//
//  ProgressBarView.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/4/20.
//

import SwiftUI

struct ProgressBar: View {
    
    var questionProgress: CGFloat
    var body: some View {
        ZStack(alignment: .leading){
            Rectangle()
                .frame(width: 350, height: 4)
                .foregroundColor(.gray)
                .cornerRadius(10)
            Rectangle()
                .frame(width: questionProgress, height: 4)
                .foregroundColor(.accentColor)
                .cornerRadius(10)
        }
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(questionProgress:50)
    }
}
