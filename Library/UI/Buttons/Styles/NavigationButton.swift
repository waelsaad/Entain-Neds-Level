//
//  NavigationButton.swift
//  Library
//
//  Created by Wael Saad on 26/02/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import SwiftUI

struct NavigationButton: ViewModifier {
    
    // MARK: - View Modifier
    
    /// Modifies the appearance and behavior of a navigation button.
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, UI.Padding.Navigation.Button.vertical)
            .padding(.horizontal, UI.Padding.Navigation.Button.horizontal)
            .background(Color.Palette.button.opacity(0.4))
            .cornerRadius(UI.Padding.Navigation.Button.cornerRadius)
    }
    
}

extension View {
    
    /// Applies a custom navigation button style to the view.
    
    func navigationButtonStyle() -> some View {
        self.modifier(NavigationButton())
    }
    
}
