//
//  GameLevel.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/5/11.
//

import SwiftUI

struct GameLevel: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var image: String
}

var gameLevels = [
    GameLevel(title: "EASY", description: "2*2 cards - 2 items", image: "single"),
    GameLevel(title: "NORMAL", description: "4*4 cards - 4 items", image: "twins"),
    GameLevel(title: "HARD", description: "4*4 cards - 8 items", image: "multiple")
]
