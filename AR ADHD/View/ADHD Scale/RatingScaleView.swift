//
//  RatingScaleView.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/4/21.
//

import SwiftUI

struct RatingScaleView: View {
    @EnvironmentObject var questionController :QuestionController
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var scaleRates: FetchedResults<ScaleRate>
    
    func saveScale(){
        do{
            let currentRate = ScaleRate(context: moc)
            currentRate.score1 = Int16(questionController.subsetScore1)
            currentRate.rate1 = questionController.subsetRate1
            currentRate.score2 = Int16(questionController.subsetScore2)
            currentRate.rate2 = questionController.subsetRate2
            currentRate.score3 = Int16(questionController.subsetScore3)
            currentRate.rate3 = questionController.subsetRate3
            try moc.save()
            print("successfully save score")
        } catch{
            print (error.localizedDescription)
        }
    }
    
    var body: some View {
        
        if questionController.reachedEnd{
          
            ScaleResultView().environmentObject(questionController)
                .navigationBarBackButtonHidden(true)
                            .navigationBarItems(leading:
                                    Button(action: goBack) {
                                        HStack {
                                            Image(systemName: "arrow.left.circle")
                                            Text("Back")
                                        }
                                    }
                                )

        }else{
        QuestionView().environmentObject(questionController)
                .navigationBarBackButtonHidden(true)
    }
    }
    func goBack(){
            //here I save CoreData context if it changes
            saveScale()
            self.presentationMode.wrappedValue.dismiss()
        }
}

struct RatingScaleView_Previews: PreviewProvider {
    static var previews: some View {
        RatingScaleView()
            .environmentObject(QuestionController())
    }
}
