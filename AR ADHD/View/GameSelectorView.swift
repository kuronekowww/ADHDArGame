//
//  GameSelectorView.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/5/5.
//

import SwiftUI

struct GameSelectorView: View {
    @StateObject var gameController = GameController()
    var body: some View {
        VStack(spacing: 40){
            Button(action: {
                gameController.isGameOver = false
                gameController.score = 0
                gameController.gameDifficulty = .easy
            },label: {
                PrimaryButton(text:"Easy")
            })
            Button(action: {
                gameController.isGameOver = false
                gameController.score = 0
                gameController.gameDifficulty = .medium
            },label: {
                PrimaryButton(text:"Medium")
            })
            
            NavigationLink {
                ContentView().environmentObject(gameController)
            } label :{
                PrimaryButton(text:"StartGame!")
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BackgroundColor"))
    }
}

struct GameSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        GameSelectorView()
    }
}
