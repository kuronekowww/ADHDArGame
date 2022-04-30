//
//  ArGameResultView.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/4/28.
//

import SwiftUI

struct GameResultView: View {
    @EnvironmentObject var gameController :GameController
    @FetchRequest(sortDescriptors: []) var gameScores: FetchedResults<GameScore>
    var body: some View {
        VStack(spacing: 20){

            Text("Completed")

            Text("Score:\(gameController.score)")
            List(gameScores){gameScore in
                Text("\(gameScore.score)")
            }
            
            NavigationLink {
                MenuView()
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

struct GameResultView_Previews: PreviewProvider {
    static var previews: some View {
        GameResultView()
    }
}
