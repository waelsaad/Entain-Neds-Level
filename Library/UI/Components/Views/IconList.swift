//
//  IconList.swift
//  Neds
//
//  Created by Wael Saad on 17/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import SwiftUI

// MARK: - View All Icons in a font. I was curious to see what icons included in neds-icon-font.ttf

struct IconList: View {
    
    let gridItems = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItems, spacing: 10) {
                ForEach(IconData.allIcons, id: \.self) { iconData in
                    VStack(alignment: .center, spacing: 10) {
                        Text(iconData.code)
                            .font(.custom("neds-icon-font", size: 44))
                        Text(iconData.name)
                            .font(.body)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }
            }
            .padding()
        }
    }
    
}

struct IconList_Previews: PreviewProvider {
    static var previews: some View {
        IconList()
    }
}

struct IconData: Hashable {
    
    let name: String
    let code: String
    
    // swiftlint:disable force_unwrapping
    
    static var allIcons: [IconData] {
            var icons: [IconData] = []
            for codePoint in 0xe000...0xefff {
                let unicodeScalar = UnicodeScalar(codePoint)!
                let icon = IconData(name: "Icon \(codePoint - 0xe000 + 1)", code: String(unicodeScalar))
                icons.append(icon)
            }
            return icons
        }
    
}
