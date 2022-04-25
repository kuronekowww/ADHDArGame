//
//  Extensions.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/4/20.
//

import Foundation
import SwiftUI

extension Text{
    func lilacTitle() -> some View{
        
        self.font(.title)
            .fontWeight(.heavy)
            .foregroundColor(Color("AccentColor"))
    }
}
