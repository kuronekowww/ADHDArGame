//
//  SwiftUIView.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/4/20.
//

import SwiftUI

struct PrimaryButton: View {
    @EnvironmentObject var gameController :GameController
    var text: String
    var background: Color = Color("AccentColor")
    
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .padding()
            .padding(.horizontal)
            .background(background)
            .cornerRadius(30)
            .shadow(radius:10)
        
    }
    private func startGame(){
        gameController.isGameOver = false
    }
}


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(text:"Scale")
    }
}
