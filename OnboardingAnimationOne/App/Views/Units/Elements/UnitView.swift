//
//  UnitView.swift
//  OnboardingAnimationOne
//
//  Created by Mariya Pankova on 18.07.2023.
//

import SwiftUI

struct UnitView: View {
    var unit: String
    var unitName: String

    var body: some View {
        HStack {
            Text(unitName.capitalized)
            Spacer()
            Text(unit)
        }
        .padding(24)
        .font(.system(size: 24))
        .frame(height: 100)
        .background(.white)
        .cornerRadius(24)
    }
}

struct UnitView_Previews: PreviewProvider {
    static var previews: some View {
        UnitView(unit: "Kilogram", unitName: "kg")
    }
}
