//
//  LazyView.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/5/22.
//

import Foundation
import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
