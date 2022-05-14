//
//  DataController.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/4/21.
//

import Foundation
import CoreData

class DataController: ObservableObject{
    
    //load and save data
    let container = NSPersistentContainer(name:"ADHDModel")
    
    init(){
        container.loadPersistentStores{ description, error in
                                        if let error = error{
                                 
            print("Core Data failed to load: \(error.localizedDescription)")
                                        } else {
                                          print("Successfully load core Data")
                                        }
        }
        
        do{
        let currentRate = ScaleRate(context: self.container.viewContext)
                currentRate.score1 = Int16(0)
                currentRate.rate1 = "Default"
                currentRate.score2 = Int16(0)
                currentRate.rate2 = "Default"
                currentRate.score3 = Int16(0)
                currentRate.rate3 = "Default"
                try self.container.viewContext.save()
        }
        catch{
            print (error.localizedDescription)
        }

        
    }
    
    
}
