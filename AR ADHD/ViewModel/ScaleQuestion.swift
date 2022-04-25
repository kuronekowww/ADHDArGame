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
    //private(set) var answerALL : [[Answer]] = []
    //private(set) var answerScale : [Answer] = []
    @Published private(set) var length = 26
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
    @Published private(set) var subsetRate1 = "default"
    @Published private(set) var subsetRate2 = "default"
    @Published private(set) var subsetRate3 = "default"

    init(){

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
        
        initAnswer(answerSet: &ans1)
        initAnswer(answerSet: &ans2)
        initAnswer(answerSet: &ans3)
        initAnswer(answerSet: &ans4)
        initAnswer(answerSet: &ans5)
        initAnswer(answerSet: &ans6)
        initAnswer(answerSet: &ans7)
        initAnswer(answerSet: &ans8)
        initAnswer(answerSet: &ans9)
        initAnswer(answerSet: &ans10)
        initAnswer(answerSet: &ans11)
        initAnswer(answerSet: &ans12)
        initAnswer(answerSet: &ans13)
        initAnswer(answerSet: &ans14)
        initAnswer(answerSet: &ans15)
        initAnswer(answerSet: &ans16)
        initAnswer(answerSet: &ans17)
        initAnswer(answerSet: &ans18)
        initAnswer(answerSet: &ans19)
        initAnswer(answerSet: &ans20)
        initAnswer(answerSet: &ans21)
        initAnswer(answerSet: &ans22)
        initAnswer(answerSet: &ans23)
        initAnswer(answerSet: &ans24)
        initAnswer(answerSet: &ans25)
        initAnswer(answerSet: &ans26)
        
        let questionTextSub1 = [
            "Often fails to give close attention to details or makes careless mistakes in schoolwork or tasks",
            "Often has difficulty sustaining attention in tasks or play activities","Often does not seem to listen when spoken to directly",
            "Often does not seem to listen when spoken to directly",
            "Often does not follow through on instructions and fails to finish schoolwork, chores, or duties",
            "Often has difficulty organizing tasks and activities",
            "Often avoids, dislikes, or reluctantly engages in tasks requiring sustained mental effort",
            "Often loses things necessary for activities (e.g., toys, school assignments, pencils or books)",
            "Often is distracted by extraneous stimuli",
            "Often is forgetful in daily activities"
        ]
        let questionTextSub2 = [
            "Often fidgets with hands or feet or squirms in seat",
            "Often leaves seat in classroom or in other situations in which remaining seated is expected",
            "Often runs about or climbs excessively in situations in which it is inappropriate",
            "Often has difficulty playing or engaging in leisure activities quietly",
            "Often is “on the go” or often acts as if “driven by a motor”",
            "Often talks excessively",
            "Often blurts out answers before questions have been completed",
            "Often has difficulty awaiting turn",
            "Often interrupts or intrudes on others (e.g., butts into conversations/ games"
        ]
        let questionTextSub3 = [
            "Often loses temper",
            "Often argues with adults",
            "Often actively defies or refuses adult requests or rules",
            "Often deliberately does things that annoy other people",
            "Often blames others for his or her mistakes or misbehaviour",
            "Often is touchy or easily annoyed by others",
            "Often is angry and resentful",
            "Often is spiteful or vindictive"
        ]
        
        let questionCategory = ["Inattention Subset","Hyperactivity/Impulsivity Subset","Opposition/Defiance Subset"]
        
        //initialize question Subset1
        self.questionSubset1.append(QuestionToScale(category: questionCategory[0], questionText: questionTextSub1[0], answers: ans1))
        self.questionSubset1.append(QuestionToScale(category: questionCategory[0], questionText: questionTextSub1[1], answers: ans2))
        self.questionSubset1.append(QuestionToScale(category: questionCategory[0], questionText: questionTextSub1[2], answers: ans3))
        self.questionSubset1.append(QuestionToScale(category: questionCategory[0], questionText: questionTextSub1[3], answers: ans4))
        self.questionSubset1.append(QuestionToScale(category: questionCategory[0], questionText: questionTextSub1[4], answers: ans5))
        self.questionSubset1.append(QuestionToScale(category: questionCategory[0], questionText: questionTextSub1[5], answers: ans6))
        self.questionSubset1.append(QuestionToScale(category: questionCategory[0], questionText: questionTextSub1[6], answers: ans7))
        self.questionSubset1.append(QuestionToScale(category: questionCategory[0], questionText: questionTextSub1[7], answers: ans8))
        self.questionSubset1.append(QuestionToScale(category: questionCategory[0], questionText: questionTextSub1[8], answers: ans9))
        
        
        //initialize question Subset2
        self.questionSubset2.append(QuestionToScale(category: questionCategory[1], questionText: questionTextSub2[0], answers: ans10))
        self.questionSubset2.append(QuestionToScale(category: questionCategory[1], questionText: questionTextSub2[1], answers: ans11))
        self.questionSubset2.append(QuestionToScale(category: questionCategory[1], questionText: questionTextSub2[2], answers: ans12))
        self.questionSubset2.append(QuestionToScale(category: questionCategory[1], questionText: questionTextSub2[3], answers: ans13))
        self.questionSubset2.append(QuestionToScale(category: questionCategory[1], questionText: questionTextSub2[4], answers: ans14))
        self.questionSubset2.append(QuestionToScale(category: questionCategory[1], questionText: questionTextSub2[5], answers: ans15))
        self.questionSubset2.append(QuestionToScale(category: questionCategory[1], questionText: questionTextSub2[6], answers: ans16))
        self.questionSubset2.append(QuestionToScale(category: questionCategory[1], questionText: questionTextSub2[7], answers: ans17))
        self.questionSubset2.append(QuestionToScale(category: questionCategory[1], questionText: questionTextSub2[8], answers: ans18))
        
        //initialize question Subset3
        self.questionSubset3.append(QuestionToScale(category: questionCategory[2], questionText: questionTextSub3[0], answers: ans19))
        self.questionSubset3.append(QuestionToScale(category: questionCategory[2], questionText: questionTextSub3[1], answers: ans20))
        self.questionSubset3.append(QuestionToScale(category: questionCategory[2], questionText: questionTextSub3[2], answers: ans21))
        self.questionSubset3.append(QuestionToScale(category: questionCategory[2], questionText: questionTextSub3[3], answers: ans22))
        self.questionSubset3.append(QuestionToScale(category: questionCategory[2], questionText: questionTextSub3[4], answers: ans23))
        self.questionSubset3.append(QuestionToScale(category: questionCategory[2], questionText: questionTextSub3[5], answers: ans24))
        self.questionSubset3.append(QuestionToScale(category: questionCategory[2], questionText: questionTextSub3[6], answers: ans25))
        self.questionSubset3.append(QuestionToScale(category: questionCategory[2], questionText: questionTextSub3[7], answers: ans26))

        //print(self.answerScale)
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
            subsetRate1 = ratingScore(category: "Inattention Subset", score: subsetScore1)
            subsetRate2 = ratingScore(category: "Hyperactivity/Impulsivity Subset", score: subsetScore2)
            subsetRate3 = ratingScore(category: "Opposition/Defiance Subset", score: subsetScore3)
            //finish scale
        }
    }
    
    func setQuestion(){
        
        answerSelected = false
        progress = CGFloat(Double(index + 1) / Double(length) * 350)
        
    switch (index+1) {
    case 1...9:
        if index < length {
            let currentQuestion = questionSubset1[indexSubset1]
            question = currentQuestion.questionText
            answerChoices = currentQuestion.answers
            indexSubset1 += 1
        }
    case 10...18:
            if index < length {
                let currentQuestion = questionSubset2[indexSubset2]
                question = currentQuestion.questionText
                answerChoices = currentQuestion.answers
                indexSubset2 += 1
            }
    case 19...26:
            if index < length {
                let currentQuestion = questionSubset3[indexSubset3]
                question = currentQuestion.questionText
                answerChoices = currentQuestion.answers
                indexSubset3 += 1
            }
    default:
        print("Error: index out of range")
    }
    }
    
    func selectedAnswer(answer: Answer){
        
        answerSelected = true
        //scaleScore += answer.point
        
        switch (index+1) {
        case 1...9:
            subsetScore1 += answer.point
        case 10...18:
            subsetScore2 += answer.point
        case 19...26:
            subsetScore3 += answer.point
        default:
            print("Error: index out of range")
        }
    }
    
    func ratingScore(category: String, score: Int) -> String{
        //"Inattention Subset","Hyperactivity/Impulsivity Subset","Opposition/Defiance Subset"
        var ratingResult : String = "default"
        
        if (category == "Inattention Subset") || (category == "Hyperactivity/Impulsivity Subset") {
            switch score {
            case 0...12:
                ratingResult = "Symptoms not clinically significant"
            case 13...17:
                ratingResult = "Mild symptoms"
            case 18...22:
                ratingResult = "Moderate symptoms"
            case 23...27:
                ratingResult = "Severe symptoms"
            default:
                ratingResult = "Error score out of range"
            }
        }
        else if (category == "Opposition/Defiance Subset"){
        switch score {
        case 0...8:
            ratingResult = "Symptoms not clinically significant"
        case 8...13:
            ratingResult = "Mild symptoms"
        case 14...18:
            ratingResult = "Moderate symptoms"
        case 19...24:
            ratingResult = "Severe symptoms"
        default:
            ratingResult = "Error score out of range"
        }
        }
        return ratingResult
    }
    
}

