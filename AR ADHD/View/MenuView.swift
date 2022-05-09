//
//  MenuView.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/4/20.
//

import SwiftUI

struct MenuView: View {
    @StateObject var questionController = QuestionController()
    //@StateObject private var dataController = DataController()
    //@StateObject var gameController = GameController()
        //@StateObject private var dataController = DataController()
    var body: some View {
        
        NavigationView {
            VStack(spacing: 40){
                VStack(spacing: 20){
            Text("Hello")
                        .lilacTitle()
                }
                NavigationLink {
                    RatingScaleView().environmentObject(questionController)
                } label :{
                    PrimaryButton(text:"StartQuiz")
                }
                NavigationLink {
                    GameSelectorView()
                        //.environment(\.managedObjectContext, dataController.container.viewContext)
                } label :{
                    PrimaryButton(text:"ARgame")
                }
                /*
                Button(action: {
                    gameController.isGameOver = false
                    gameController.score = 0
                },label: {
                    PrimaryButton(text:"resetGame")
                })
                */
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
        .background(Color("BackgroundColor"))
        }
        .navigationViewStyle(.stack)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
