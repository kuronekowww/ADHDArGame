//
//  ContentView.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/4/10.
//

import SwiftUI
import RealityKit
import Combine


struct ContentView : View{

    //@StateObject private var dataController = DataController()
    //@Environment(\.managedObjectContext) var moc
    @EnvironmentObject var gameController :GameController
    //@FetchRequest(sortDescriptors:[]) var scores: FetchedResults<GameScore>
    
    var body: some View{
        if !gameController.isGameOver{
        VStack{
        ARGameViewContainer(gameController.arView)
                .edgesIgnoringSafeArea(.all)
        }
        //.padding(.top)
        .edgesIgnoringSafeArea(.all)
        .overlay(
            ZStack{
                Color.clear
                    .background(.ultraThinMaterial)
                Text("Time: \(gameController.timerCount)")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                Text("Score:\(gameController.score)")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 200)
            }
            .frame(height: 70)
            .frame(maxHeight: .infinity, alignment: .top))
        .navigationBarHidden(true)
        } else{
            GameResultView().environmentObject(gameController)
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
