//
//  View+ViewThatFits.swift
//  Library
//
//  Created by Wael Saad on 17/7/2022.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

struct ViewThatFitsModifier: ViewModifier {

    func body(content: Content) -> some View {
        ViewThatFits(in: .vertical) {
            content
            ScrollView(.vertical, showsIndicators: false) { content }
        }
    }
    
}

extension View {
    
    func viewThatFits() -> some View {
        self.modifier(ViewThatFitsModifier())
    }
    
}
