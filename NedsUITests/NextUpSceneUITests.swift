//
//  NextUpSceneUITests.swift
//  Neds
//
//  Created by Wael Saad on 17/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

@testable import Neds
import XCTest
import SwiftUI

class NextUpSceneTests: XCTestCase {
    
    // swiftlint:disable implicitly_unwrapped_optional
    
    private var viewModel: NextUpScene.NextUpViewModel!
    
    private var scene: NextUpScene!
    
    override func setUp() {
        super.setUp()
        viewModel = NextUpScene.NextUpViewModel()
        scene = NextUpScene(viewModel: self.viewModel)
    }
    
    override func tearDown() {
        viewModel = nil
        scene = nil
        super.tearDown()
    }
    
    // TODO: To be Continued.. :]
    
}
