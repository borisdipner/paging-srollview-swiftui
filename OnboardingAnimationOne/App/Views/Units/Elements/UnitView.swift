//
//  UnitView.swift
//  OnboardingAnimationOne
//
//  Created by Mariya Pankova on 18.07.2023.
//

import SwiftUI

struct UnitView: View {
    let itemSide: CGFloat
    var value: String
    var unit: String
    var unitName: String

    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                Text(value)
                    .font(.system(size: 20))
                Text(unit)
                    .font(.system(size: 16))
                Spacer()
            }
            Text(unitName)
                .font(.system(size: 14))
        }
        .minimumScaleFactor(0.1)
        .padding(12)
        .frame(height: itemSide)
        .background(.white)
        .cornerRadius(16)
    }
}

struct UnitView_Previews: PreviewProvider {
    static var previews: some View {
        UnitView(itemSide: 80, value: "5", unit: "Kilogram", unitName: "kg")
    }
}
