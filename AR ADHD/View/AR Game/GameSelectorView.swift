//
//  GameSelectorView.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/5/5.
//

import SwiftUI

struct GameSelectorView: View {
    @StateObject var gameController = GameController()
    @State var gameDifficulty : String = "EASY"
    @State public var selectedTab = 0
    
    func switchTab(){
        switch selectedTab{
        case 0: gameController.isGameOver = false
                gameController.score = 0
                gameController.gameDifficulty = .easy
        case 1: gameController.isGameOver = false
                gameController.score = 0
                gameController.gameDifficulty = .medium
        case 2: gameController.isGameOver = false
                gameController.score = 0
                gameController.gameDifficulty = .hard
        default: gameController.isGameOver = false
                gameController.score = 0
                gameController.gameDifficulty = .easy
        }
        print(gameDifficulty)
    }
    
    var body: some View {
        NavigationView{
            VStack{
                TabView(selection: $selectedTab) {
                    GameSelection(gamelevel: gameLevels[0])
                        .tag(0)
                    GameSelection(gamelevel: gameLevels[1])
                        .tag(1)
                    GameSelection(gamelevel: gameLevels[2])
                        .tag(2)
                    /*
                    ForEach(gameLevels) { item in
                        GameSelection(gamelevel: item)
                    }
                     */
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height:430)
                .background(Image("selectionBackground")
                                .resizable(resizingMode: .stretch)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .foregroundColor(.white))
                /*
                Button(action: {
                    /*
                    gameController.isGameOver = false
                    gameController.score = 0
                    gameController.gameDifficulty = .easy
                     */
                },label: {
                    PrimaryButton(text:"Easy")
                })
                Button(action: {
                    /*
                    gameController.isGameOver = false
                    gameController.score = 0
                    gameController.gameDifficulty = .medium
                     */
                },label: {
                    PrimaryButton(text:"Medium")
                })
                */
                NavigationLink {
                    ContentView().environmentObject(gameController)
                        .onAppear{ switchTab() }
                } label :{
                        PrimaryButton(text:"Start")
                }
                
                .padding(.top, 40)
                
                NavigationLink {
                    HistoryScoreView()
                } label :{
                    PrimaryButton(text:"Myscore")
                }
                .padding(.top, 40)
                //Spacer()
            }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Image("gameSelectBackground2")
                        .resizable())
        .edgesIgnoringSafeArea(.all)
        .overlay(
            NavigationBar(title:"Select Game Difficulty")
                .foregroundColor(.white)
        )
    }
        .navigationViewStyle(.stack)
    //.edgesIgnoringSafeArea(.all)
    }
}

struct GameSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        GameSelectorView()
    }
}
