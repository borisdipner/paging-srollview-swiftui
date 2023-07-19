//
//  UnitsView.swift
//  OnboardingAnimationOne
//
//  Created by Mariya Pankova on 18.07.2023.
//

import SwiftUI

enum Constants {
    static let itemSide: CGFloat = 100
    static let itemPadding: CGFloat = 20
    static let visibleContentLength: CGFloat = 600
}

struct UnitsView: View {
    let unitData = UnitRowsData()

    @State private var activePageIndex: Int = 0

    var body: some View {
        VStack {
            Spacer(minLength: 160)
            GeometryReader { geometry in
                AdaptivePagingScrollView(currentPageIndex: self.$activePageIndex,
                                         itemsAmount: self.unitData.units.count - 1,
                                         itemScrollableSide: Constants.itemSide,
                                         itemPadding: Constants.itemPadding,
                                         visibleContentLength: Constants.visibleContentLength,
                                         orientation: .vertical) {
                    ForEach(unitData.units, id: \.self) { card in
                        GeometryReader { screen in
                            UnitView(unit: card.unit, unitName: card.unitName)
                                .scaleEffect(activePageIndex == unitData.units.firstIndex(of: card) ?? 0 ? 1 : 0.95)
                        }

                    }
                }
                                         .background(Color.yellow.opacity(0.4))
            }
            Spacer()
        }
        .background(Color.yellow.opacity(0.1))
    }
}

struct UnitsView_Previews: PreviewProvider {
    static var previews: some View {
        UnitsView()
    }
}
