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
    @FetchRequest(sortDescriptors:[]) var scores: FetchedResults<GameScore>
    var body: some View{
        if !gameController.isGameOver{
        VStack(alignment: .leading){
            Text("Time: \(gameController.timerCount)")
            Text("Score:\(gameController.score)")
                .background(.white)
                .font(.title)
        ARGameViewContainer(gameController.arView)
                .edgesIgnoringSafeArea(.all)
        }
        .padding(.top)
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
