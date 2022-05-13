//
//  SlideSelector.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/5/11.
//

import SwiftUI

struct SlideSelector: View {
    @State public var selectedTab = 0
    //@State var gameDifficulty : String = "EASY"
    
    var body: some View {
        //VStack{
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
        }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("gameSelectBackground2")
                            .resizable())
            .edgesIgnoringSafeArea(.all)
   */
    }
}


struct SlideSelector_Previews: PreviewProvider {
    static var previews: some View {
        SlideSelector()
    }
}
