//
//  Tab.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/5/9.
//

import SwiftUI

struct TabItem: Identifiable {
    var id = UUID()
    var text: String
    var icon: String
    var tab: Tab
}

var tabItems = [
    TabItem(text: "Main", icon: "house", tab: .main),
    TabItem(text: "Game", icon: "gamecontroller", tab: .game),
    TabItem(text:"Profile",icon:"person", tab: .profile)
]

enum Tab: String{
    case main
    case game
    case profile
}
