//
//  MenuView.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/4/20.
//

import SwiftUI

struct MenuView: View {
    @StateObject var questionController = QuestionController()
    @StateObject var gameController = GameController()
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
                    PrimaryButton(text:"Start")
                }
                NavigationLink {
                    ContentView().environmentObject(gameController)
                } label :{
                    PrimaryButton(text:"AR")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
        .background(Color("BackgroundColor"))
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
