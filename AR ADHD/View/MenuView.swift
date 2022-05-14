//
//  MenuView.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/4/20.
//

import SwiftUI

struct MenuView: View {
    //@StateObject private var dataController = DataController()
    //@StateObject var gameController = GameController()
        //@StateObject private var dataController = DataController()
    @StateObject var questionController = QuestionController()
    @Namespace var namespace
    @State var show = false
    
    var body: some View {
        
        NavigationView{
            VStack(spacing: 40){
                NavigationLink {
                    RatingScaleView().environmentObject(questionController)
                } label :{
                    SectionItemView()
                }
                if !show {
                    IntroductionItem(namespace: namespace, show: $show)
                    .onTapGesture {
                        withAnimation(.spring(response:0.6,dampingFraction: 0.8)){
                            show.toggle()
                        }
                    }
                    .padding(.top, 20.0)
                }
            /*
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
                */
                
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
            .background(Image("mainScreenBackground"))
            .overlay(show ?
                    IntroductionView(namespace: namespace, show: $show)
                     : nil)
        }
        .navigationViewStyle(.stack)
        /*
            .overlay(
                NavigationBar(title:"Topic")
                    .foregroundColor(.white)
            )
         */
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
.previewInterfaceOrientation(.portraitUpsideDown)
    }
}
