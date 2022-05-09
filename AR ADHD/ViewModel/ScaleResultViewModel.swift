//
//  ScaleResultViewModel.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/5/7.
//

import Foundation
import CoreData

class ScaleResultViewModel: ObservableObject{
    
    private (set) var context: NSManagedObjectContext
    
    init(context:NSManagedObjectContext){
        self.context = context
    }
}
