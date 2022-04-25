//
//  Question.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/4/23.
//

import Foundation

struct QuestionToScale: Identifiable{
    
    var id = UUID()
    var category : String
    var questionText: String
    var answers : [Answer]
    
}
