//
//  MenuView.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/4/20.
//

import SwiftUI

struct MenuView: View {
    //@StateObject var questionController = QuestionController()
    //@StateObject private var dataController = DataController()
    //@StateObject var gameController = GameController()
        //@StateObject private var dataController = DataController()
    
    var body: some View {
        
        VStack{
            SectionItemView()
            
        }
            .overlay(
                NavigationBar(title:"Topic")
            )
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
.previewInterfaceOrientation(.portraitUpsideDown)
    }
}
