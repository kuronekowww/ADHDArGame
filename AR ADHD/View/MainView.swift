//
//  MainView.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/5/10.
//

import SwiftUI

struct MainView: View {
    @AppStorage("selectedtab") var selectedTab: Tab = .main
    var body: some View {
        ZStack(alignment: .bottom) {
            Group{
                switch selectedTab{
                case .main:
                MenuView()
                case .game:
                GameSelectorView()
                case .profile:
                RatingScaleView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        TabBar()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
