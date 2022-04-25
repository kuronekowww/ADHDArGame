//
//  ScaleQuestion.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/4/21.
//

import Foundation
import SwiftUI

class QuestionController:ObservableObject{
    private(set) var questionSubset1 : [QuestionToScale] = []
    private(set) var questionSubset2 : [QuestionToScale] = []
    private(set) var questionSubset3 : [QuestionToScale] = []
    private(set) var answerALL : [[Answer]] = []
    private(set) var answerScale : [Answer] = []
    @Published private(set) var length = 2
    @Published private(set) var index = 0
    @Published private(set) var indexSubset1 = 0
    @Published private(set) var indexSubset2 = 0
    @Published private(set) var indexSubset3 = 0
    @Published private(set) var reachedEnd = false
    @Published private(set) var answerSelected = false
    @Published private(set) var question : String = ""
    @Published private(set) var answerChoices: [Answer] = [ ]
    @Published private(set) var progress: CGFloat = 0.8
    @Published private(set) var scaleScore = 0
    @Published private(set) var subsetScore1 = 0
    @Published private(set) var subsetScore2 = 0
    @Published private(set) var subsetScore3 = 0

    init(){
/*
        var ans1 = Answer(text:"Not at all", point:0)
        var ans2 = Answer(text:"Just a little", point:1)
        var ans3 = Answer(text:"Quite a bit", point:2)
        var ans4 = Answer(text:"Very Much", point:3)
                    /*
        self.answerScale.append(Answer(text:"Not at all", point:0))
        self.answerScale.append(Answer(text:"Just a little", point:1))
        self.answerScale.append(Answer(text:"Quite a bit", point:2))
        self.answerScale.append(Answer(text:"Very Much", point:3))
                     */
        self.answerScale.append(ans1)
        self.answerScale.append(ans2)
        self.answerScale.append(ans3)
        self.answerScale.append(ans4)
        
     
        let questionText = ["Often fails to give close attention to details or makes careless mistakes in schoolwork or tasks","Often has difficulty sustaining attention in tasks or play activities"]
        let questionCategory = ["A","A"]
        self.questionToScale.append(QuestionToScale(category: questionCategory[0], questionText: questionText[0], answers: self.answerScale))

        self.questionToScale.append(QuestionToScale(category: questionCategory[1], questionText: questionText[1], answers: self.answerScale))

        print(self.answerScale)
        */
        initQuestion()
        setQuestion()
    }
    
    func initAnswer(answerSet: inout [Answer]){ //pass by reference
        
        let NotAtAll = Answer(text:"Not at all", point:0)
        let JustALittle = Answer(text:"Just a little", point:1)
        let QuiteABit = Answer(text:"Quite a bit", point:2)
        let VeryMuch = Answer(text:"Very Much", point:3)
        answerSet.append(NotAtAll)
        answerSet.append(JustALittle)
        answerSet.append(QuiteABit)
        answerSet.append(VeryMuch)
        
    }
    func initQuestion(){
        var ans1: [Answer] = []
        var ans2: [Answer] = []
        /*
        var ans3: [Answer] = []
        var ans4: [Answer] = []
        var ans5: [Answer] = []
        var ans6: [Answer] = []
        var ans7: [Answer] = []
        var ans8: [Answer] = []
        var ans9: [Answer] = []
        var ans10: [Answer] = []
        var ans11: [Answer] = []
        var ans12: [Answer] = []
        var ans13: [Answer] = []
        var ans14: [Answer] = []
        var ans15: [Answer] = []
        var ans16: [Answer] = []
        var ans17: [Answer] = []
        var ans18: [Answer] = []
        var ans19: [Answer] = []
        var ans20: [Answer] = []
        var ans21: [Answer] = []
        var ans22: [Answer] = []
        var ans23: [Answer] = []
        var ans24: [Answer] = []
        var ans25: [Answer] = []
        var ans26: [Answer] = []
         */
        
        initAnswer(answerSet: &ans1)
        initAnswer(answerSet: &ans2)
        let questionText = ["Often fails to give close attention to details or makes careless mistakes in schoolwork or tasks","Often has difficulty sustaining attention in tasks or play activities"]
        let questionCategory = ["A","A"]
        self.questionSubset1.append(QuestionToScale(category: questionCategory[0], questionText: questionText[0], answers: ans1))

        self.questionSubset2.append(QuestionToScale(category: questionCategory[1], questionText: questionText[1], answers: ans2))

        print(self.answerScale)
    }
    /*
    lazy var initScaleTest: Void = {
        self.answerScale.append(Answer(text:"Not at all", point:0))
        self.answerScale.append(Answer(text:"Just a little", point:1))
        self.answerScale.append(Answer(text:"Quite a bit", point:2))
        self.answerScale.append(Answer(text:"Very Much", point:4))
        
        let questionText = ["Often fails to give close attention to details or makes careless mistakes in schoolwork or tasks","Often has difficulty sustaining attention in tasks or play activities"]
        let questionCategory = ["A","A"]
        self.questionToScale.append(QuestionToScale(category: questionCategory[0], questionText: questionText[0], answers: self.answerScale))
        self.questionToScale.append(QuestionToScale(category: questionCategory[1], questionText: questionText[1], answers: self.answerScale))

        print(self.questionToScale)
    }()
    */
    
    func goToNextQuestion(){
        
        if index + 1 < length{
            index += 1
            setQuestion()
            //jump to next question
        }
        else{
            reachedEnd = true
            //finish scale
        }
    }
    
    func setQuestion(){
        answerSelected = false
        progress = CGFloat(Double(index + 1) / Double(length) * 350)
        
    switch (index+1) {
    case 1:
        if index < length {
            let currentQuestion = questionSubset1[indexSubset1]
            question = currentQuestion.questionText
            answerChoices = currentQuestion.answers
            indexSubset1 += 1
        }
    case 2:
            if index < length {
                let currentQuestion = questionSubset2[indexSubset2]
                question = currentQuestion.questionText
                answerChoices = currentQuestion.answers
                indexSubset2 += 1
            }
    default:
        
        if index < length {
            let currentQuestion = questionSubset1[index]
            question = currentQuestion.questionText
            answerChoices = currentQuestion.answers
        }
    }
    }
    
    func selectedAnswer(answer: Answer){
        answerSelected = true
        //scaleScore += answer.point
        
        switch (index+1) {
        case 1:
            subsetScore1 += answer.point
        case 2:
            subsetScore2 += answer.point
        default:
            subsetScore3 += answer.point
           
        }
    }
    
    
}

