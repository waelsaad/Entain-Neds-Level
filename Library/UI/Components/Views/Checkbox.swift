//
//  Checkbox.swift
//  Neds
//
//  Created by Wael Saad on 19/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import SwiftUI

struct Checkbox: View {
    
    // MARK: - Properties
    
    var isChecked: Bool
    var category: RaceCategory?
    var labelText: LocalizedStringKey?
    
    var action: () -> Void
    
    // MARK: - Body
    
    var body: some View {
        Button(action: action) {
            checkboxContent
        }
        .foregroundColor(.Palette.primary)
    }
    
    // MARK: - Private Views
    
    private var checkboxContent: some View {
        HStack {
            checkboxImage
            categoryImage
            labelView
        }
        .foregroundColor(.Palette.primary)
        .clipShape(Rectangle())
    }
    
    // Display either a checkmark or a square icon based on the isChecked state

    private var checkboxImage: some View {
        Image(systemImage: isChecked ? .checkmark : .square)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(size: UI.IconSize.standard)
    }
    
    // Display an image corresponding to the category, if available
    
    @ViewBuilder
    private var categoryImage: some View {
        if let category = category {
            Image(category.imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.black)
                .aspectRatio(contentMode: .fit)
                .frame(size: UI.IconSize.categoryIcon)
        }
    }
    
    // Display the label text, if available
    
    @ViewBuilder
    private var labelView: some View {
        if let labelText = labelText {
            Text(labelText)
        }
    }
    
}

// MARK: - Preview

struct Checkbox_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("INTL")
        }
    }
}
