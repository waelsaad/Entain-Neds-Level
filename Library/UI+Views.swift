//
//  UI+Views.swift
//  Library
//
//  Created by Wael Saad on 20/6/2022.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

extension UI {
    
    static var orangeGradient: some View {
        Gradient.orangeGradient
            .edgesIgnoringSafeArea(.all)
    }
    
}

extension Gradient {

    static var orangeGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(stops: [
                .init(color: Color.Palette.primary, location: 0),
                .init(color: Color.Palette.secondary, location: 0.4), 
                .init(color: Color.Palette.secondary, location: 1)
            ]),
            startPoint: .leading,
            endPoint: .trailing
        )
    }

}
