//
//  LeadingNavigationItemsView.swift
//  Neds
//
//  Created by Wael Saad on 17/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import SwiftUI

// MARK: - NextUpScene

struct LeadingNavigationItemsView: View {
    
    /// The view displaying the logo image.
    
    var body: some View {
        LogoView()
            .accessibilityLabel("App Logo")
    }

    private struct LogoView: View {
        var body: some View {
            Image(appImage: .logo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UI.Dimensions.Logo.width)
        }
    }
    
}
