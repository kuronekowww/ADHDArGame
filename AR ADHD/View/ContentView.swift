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
 
    @EnvironmentObject var gameController :GameController
    var body: some View{
        VStack(alignment: .leading){
            //Text("Score \(gameController.score)")
            Text("Score")
                .background(.white)
                .font(.title)
        ARGameViewContainer(gameController.arView)
        }
        .padding(.top)
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
