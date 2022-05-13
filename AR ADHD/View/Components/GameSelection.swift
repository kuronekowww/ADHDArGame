//
//  GameSelection.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/5/10.
//

import SwiftUI

struct GameSelection: View {
    var gamelevel: GameLevel = gameLevels[0]

    
    var body: some View {
            VStack(alignment: .center, spacing: 5.0){
            Spacer()
                Text(gamelevel.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .dynamicTypeSize(/*@START_MENU_TOKEN@*/.accessibility5/*@END_MENU_TOKEN@*/)
                Text(gamelevel.description)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
            
        }
        .padding(.bottom, 2)
        .frame(width: 414, height: 320)
        .padding(.vertical,20)
        .background(Image(gamelevel.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height:280)
                    .offset(x:0,y:-50))
        //.background(.white.opacity(0.3),in:RoundedRectangle(cornerRadius: 40,style:.continuous))
        //.background(.white.opacity(0.3))
        //.mask(RoundedRectangle(cornerRadius: 30,style:.continuous))
        .shadow(color: Color("Shadow").opacity(0.3), radius: 10, x: 0, y: 10)
        .padding(.horizontal,0)
    }

}
struct GameSelection_Previews: PreviewProvider {
    static var previews: some View {
        GameSelection()
    }
}
