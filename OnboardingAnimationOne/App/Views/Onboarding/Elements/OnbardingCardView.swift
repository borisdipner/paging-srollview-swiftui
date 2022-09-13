//
//  OnbardingCardView.swift
//  OnboardingAnimationOne
//
//  Created by Boris on 06.09.2022.
//

import SwiftUI

struct OnbardingCardView: View {
    
    var card: OnboardingCard
    
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            Text(card.title.capitalized)
                .colorInvert()
                .font(.system(size: 48, weight: .bold, design: .rounded))
            VStack(alignment: .leading, spacing: 25) {
                Text(card.subTitle)
                    .colorInvert()
                    .font(.bold(.headline)())
                    .lineLimit(3)
                    .frame(width: 200)
                    .fixedSize()
                    .padding()
                Image(card.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 200, alignment: .center)
            }
            .padding(20)
            .background(Color.nightBlue)
            .cornerRadius(25)
        }
    }
}


