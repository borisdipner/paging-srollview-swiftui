//
//  OnboardingContinueButton.swift
//  OnboardingAnimationOne
//
//  Created by Boris on 07.09.2022.
//

import SwiftUI

struct OnboardingContinueButton: View {
    
    @Binding var isReadyToContinue: Bool
    @Binding var isPresented: Bool
    @State private var animateGradient = false

    var body: some View {
        Button(action: { isPresented = false }) {

            let buttonTitle = isReadyToContinue ? "Let's continue" : "Skip"
            let buttonImage = isReadyToContinue ? "location.fill" : "location"
            let gradientColors = isReadyToContinue ? [Color.purple, Color.nightBlue] : [Color.purple, Color.black]
            
            HStack {
                Image(systemName: buttonImage)
                    .foregroundColor(Color.white)
                    .frame(width: 20, height: 20)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                Text(buttonTitle)
                    .font(.bold(.subheadline)())
                    .foregroundColor(Color.white)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 40))
                
            }
            .padding(5)
            .background(
                LinearGradient(colors: gradientColors,
                               startPoint: animateGradient ? .topLeading : .bottomLeading,
                               endPoint: animateGradient ? .bottomTrailing : .topTrailing)
                .ignoresSafeArea()
            )
            .cornerRadius(15)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 2.0).repeatForever(autoreverses: true)) {
                animateGradient.toggle()
            }
        }
    }
}


