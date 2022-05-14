//
//  HistoryScoreView.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/5/8.
//

import SwiftUI

struct HistoryScoreView: View {
    @FetchRequest(sortDescriptors: []) var gameScores: FetchedResults<GameScore>
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack(spacing: 40){
            Text("History scores")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color("AccentColor"))
                .frame(maxWidth: .infinity,alignment: .topTrailing)
                .padding(.trailing, 10)
            List(gameScores){gameScore in
                
                HStack(spacing:20) {
                    Text("Level: \(gameScore.historyLevel ?? "EASY")")
                        .frame(width:200)
                    Text("Score:  \(gameScore.historyScore)")
                }
            }
            .listStyle(.automatic)
            }
        .background(.background)
          /*
        List(gameScores){gameScore in
            Text("\(gameScore.historyScore)")}
        }
           */
    }
}

struct HistoryScoreView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryScoreView()
    }
}
