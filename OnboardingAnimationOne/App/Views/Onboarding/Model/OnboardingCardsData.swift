//
//  PageViewController.swift
//  OnboardingAnimationOne
//
//  Created by Boris on 05.09.2022.
//

import SwiftUI

class OnboardingCardsData: ObservableObject {
    
    let cards: [OnboardingCard]
    
    var primary: OnboardingCard {
        cards.first!
    }
    
    init() {
        cards = Bundle.main.decode([OnboardingCard].self, from: "cards.json")
    }
}
