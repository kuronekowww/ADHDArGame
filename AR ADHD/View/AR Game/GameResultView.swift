//
//  ArGameResultView.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/4/28.
//

import SwiftUI
import RealityKit

struct GameResultView: View {
    @EnvironmentObject var gameController :GameController
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    
    
    func goBack(){
            saveScore()
            self.presentationMode.wrappedValue.dismiss()
        }
    
    func saveScore(){
        do{
            let currentScore = GameScore(context: moc)
            currentScore.historyScore = Int16(gameController.score)
            let transLevel = gameController.gameDifficulty
            currentScore.historyLevel = "NORMAL"
            currentScore.id = UUID()
            try moc.save()
            print("successfully save score")
        } catch{
            print (error.localizedDescription)
        }
    }
    
    var body: some View {
        VStack(spacing: 20){
            
            Text("GAME OVER")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.white)
                .padding(.top, 100)
                .background(Image("cloud")
                                .resizable(resizingMode: .stretch)
                                .frame(width: 382,height:283)
                                .offset(y:-150))
            Text("Score:  \(gameController.score)")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(Color.white)
            //Text("Score:  \(gameController.score)")
            
            
            
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Image("HistoryScoreBackground")
                        .resizable(resizingMode: .stretch))
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        /*
                    .navigationBarItems(leading:
                            Button(action: goBack) {
                                HStack {
                                    Image(systemName: "arrow.left.circle")
                                    Text("Back")
                                }
                            }
                        )
        */
    }
}

struct GameResultView_Previews: PreviewProvider {
    static var previews: some View {
        GameResultView()
    }
}
