//
//  OnboardingCard.swift
//  OnboardingAnimationOne
//
//  Created by Boris on 07.09.2022.
//

import SwiftUI

struct OnboardingCard: Codable, Identifiable, Equatable {

    var id: UUID
    var title: String
    var subTitle: String
    var image: String
}
