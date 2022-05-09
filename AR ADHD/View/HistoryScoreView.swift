//
//  HistoryScoreView.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/5/8.
//

import SwiftUI

struct HistoryScoreView: View {
    @FetchRequest(sortDescriptors: []) var gameScores: FetchedResults<GameScore>
    
    var body: some View {
        VStack(spacing: 40){
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        List(gameScores){gameScore in
            Text("\(gameScore.historyScore)")}
        }
    }
}

struct HistoryScoreView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryScoreView()
    }
}
