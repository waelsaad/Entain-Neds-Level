//
//  TrailingNavigationItemsView.swift
//  Neds
//
//  Created by Wael Saad on 17/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import SwiftUI

// MARK: - NextUpScene

struct TrailingNavigationItemsView: View {
    
    /// The count of notifications to display in the badge.
    
    var notificationsCount: Int

    var body: some View {
        HStack(spacing: UI.Space.xxxSmall) {
            SearchIconView()
                .accessibilityLabel("Search Icon")
            LoginButtonView()
                .accessibilityLabel("Login Button")
            JoinButtonView()
                .accessibilityLabel("Join Button")
            NotificationBadgeView(count: notificationsCount)
                .accessibilityLabel("Notification Badge")
        }
    }

    /// View displaying the search icon.
    
    private struct SearchIconView: View {
        var body: some View {
            Image(systemImage: .search)
                .resizable()
                .frame(size: UI.IconSize.searchIcon)
                .foregroundColor(.white)
        }
    }

    /// View representing the login button.
    
    private struct LoginButtonView: View {
        var body: some View {
            Button {
                // Handle login action
            } label: {
                Text(GlobalContent.login)
                    .foregroundColor(.white)
            }
            .navigationButtonStyle()
        }
    }

    /// View representing the join button.
    
    private struct JoinButtonView: View {
        var body: some View {
            Button {
                // Handle join action
            } label: {
                Text(GlobalContent.join)
                    .foregroundColor(.white)
            }
            .navigationButtonStyle()
        }
    }

    /// View displaying the notification badge.
    
    private struct NotificationBadgeView: View {
        
        /// The count of notifications to display in the badge.
        
        var count: Int

        var body: some View {
            ZStack {
                Circle()
                    .fill(Color.accentColor)
                    .frame(size: UI.Padding.Navigation.Badge.radius)
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: UI.Padding.Navigation.Badge.borderWidth)
                    )
                Text(String(count))
                    .foregroundColor(.white)
                    .font(Font.body.weight(.bold))
            }
        }
        
    }
    
}
