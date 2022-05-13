//
//  ArGameResultView.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/4/28.
//

import SwiftUI
import RealityKit

struct GameResultView: View {
    //@EnvironmentObject var gameController :GameController
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var gameScores: FetchedResults<GameScore>
    /*
    func saveScore(){
        do{
            let currentScore = GameScore(context: moc)
            currentScore.historyScore = Int16(gameController.score)
            currentScore.id = UUID()
            try moc.save()
            print("successfully save score")
        } catch{
            print (error.localizedDescription)
        }
    }
    */
    var body: some View {
        VStack(spacing: 20){

            Text("Completed")

            //Text("Score:\(gameController.score)")
            
            NavigationLink(
            destination: HistoryScoreView(),
            label: {
                Button(action:{
                //saveScore()
            },label:{
                PrimaryButton(text:"back")
            })}
            )
            
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
