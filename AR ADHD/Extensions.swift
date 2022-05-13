//
//  Extensions.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/4/20.
//

import Foundation
import SwiftUI

extension Text{
    
    func sectionTitle() -> some View{
        //For sections in menuview
        self.font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.accentColor)
    }
    
    func sectionNote() -> some View{
        
        self.font(.footnote)
            .fontWeight(.semibold)
            .foregroundColor(.secondary)
        
    }
}
