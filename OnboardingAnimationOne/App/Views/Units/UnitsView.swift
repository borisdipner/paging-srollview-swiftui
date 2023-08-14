//
//  UnitsView.swift
//  OnboardingAnimationOne
//
//  Created by Mariya Pankova on 18.07.2023.
//

import SwiftUI

struct UnitsView: View {

    @State var activeIndex: Int = 0
    @Binding var value: String
    @Binding var isPresented: Bool

    let unitData: UnitRowsData
    let itemSide: CGFloat
    let itemPadding: CGFloat
    let visibleContentLength: CGFloat
    let onChangeActiveIndex: (Int) -> ()

    var body: some View {
        VStack {
            Spacer(minLength: 160)
            GeometryReader { geometry in
                AdaptivePagingScrollView(currentPageIndex: $activeIndex,
                                         itemsAmount: unitData.units.count - 1,
                                         itemScrollableSide: itemSide,
                                         itemPadding: itemPadding,
                                         visibleContentLength: visibleContentLength,
                                         orientation: .vertical) {
                    ForEach(unitData.units, id: \.self) { card in
                        let isSelectedCard = activeIndex == unitData.units.firstIndex(of: card) ?? 0
                        GeometryReader { screen in
                            UnitView(
                                itemSide: itemSide,
                                value: isSelectedCard ? value : "",
                                unit: card.unit,
                                unitName: card.unitName
                            )
                            .scaleEffect(isSelectedCard ? 1 : 0.9)
                        }

                    }
                }
                                         .clipped()
                                         .background(Color.black.opacity(0.2))
            }
            Spacer()
            Button("Dismiss", action: { isPresented = false })
                .padding(8)
                .background(Color.black.opacity(0.3))
                .font(Font.system(size: 20, weight: .semibold))
                .foregroundColor(Color.white)
                .cornerRadius(8)
            Spacer()
        }
        .onChange(of: activeIndex, perform: onChangeActiveIndex)
    }

    init(unitData: UnitRowsData = .init(),
         value: Binding<String> = .constant(""),
         isPresented: Binding<Bool>,
         itemSide: CGFloat = 80,
         itemPadding: CGFloat = 16,
         visibleContentLength: CGFloat = 300,
         onChangeActiveIndex: @escaping (Int) -> () = { _ in }) {
        self.itemSide = itemSide
        self._value = value
        self._isPresented = isPresented
        self.itemPadding = itemPadding
        self.visibleContentLength = visibleContentLength
        self.unitData = unitData
        self.onChangeActiveIndex = onChangeActiveIndex
    }
}

struct UnitsView_Previews: PreviewProvider {
    static var previews: some View {
        UnitsView(unitData: .init(), value: .constant(""), isPresented: .constant(false), onChangeActiveIndex: { _ in })
    }
}
