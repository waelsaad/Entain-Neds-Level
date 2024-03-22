//
//  AppScene.swift
//  Neds
//
//  Created by Wael Saad on 17/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import SwiftUI

@main
struct AppScene: App {
    
    @ObservedObject var viewModel = AppScene.AppViewModel()
    
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    private var background: some View { UI.orangeGradient }
    
    init() {
        
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                NextUpScene(viewModel: .init())
                    .background(background)
            }
        }
    }
}
