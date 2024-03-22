//
//  ErrorView.swift
//  Neds
//
//  Created by Wael Saad on 19/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import SwiftUI

struct ErrorView: View {
    
    // Represents the error to be displayed in the view
   
    let error: AppError
    
    // Action to be performed when the retry button is tapped
    
    let retryAction: () -> Void
    
    // View hierarchy representing the error screen
    
    var body: some View {
        ZStack {
            Color.Palette.backgroundError.edgesIgnoringSafeArea(.all)
            VStack(spacing: UI.Space.xSmall) {
                logoView
                errorImage
                errorTitle
                errorDescription
                retryButton
            }
            .align(.top)
            .navigationBarHidden(true)
        }
    }
    
    // Logo view displayed at the top of the error screen
    
    private var logoView: some View {
        Image(appImage: .logo)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: UI.Error.Logo.width)
            .padding(.top, UI.Error.Logo.top)
            .padding(.bottom, UI.Error.Logo.bottom)
            .accessibility(hidden: true) // Hide logo from accessibility
    }
    
    // Image representing the error
    
    private var errorImage: some View {
        Image(appImage: .connection_error)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: UI.Error.Image.width)
            .accessibility(label: Text("Connection Error Image"))
            .accessibility(hint: Text("Tap to retry"))
    }
    
    // Title of the error
    
    private var errorTitle: some View {
        Text(GlobalContent.connectionError)
            .font(.title)
            .bold()
            .foregroundColor(.white)
            .accessibility(label: Text("Connection Error"))
    }
    
    // Description of the error directly from the server
    
    private var errorDescription: some View {
        Text(error.localized)
            .font(.headline)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
            .foregroundColor(.white)
            .padding(.bottom, UI.Error.Description.bottom)
            .accessibility(label: Text("Error Description"))
    }
    
    // Retry button to attempt the action again
    
    private var retryButton: some View {
        Button(action: retryAction) {
            Text(GlobalContent.tryAgain)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(height: UI.Error.RetryButton.height)
                .frame(maxWidth: .infinity)
                .background(Color.Palette.silletto)
                .cornerRadius(UI.Error.RetryButton.cornerRadius)
                .accessibility(label: Text("Retry Button"))
        }
        .padding(.horizontal, UI.Error.RetryButton.horizontal)
        .accessibility(hint: Text("Double-tap to retry")) // Hint for VoiceOver users
    }
    
}

// MARK: - Preview

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(
            error: .noInternet(URLError(.notConnectedToInternet))
        ) {
            // Your retry action code here
        }
    }
}
