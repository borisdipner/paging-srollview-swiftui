//
//  AdaptivePagingScrollView.swift
//  OnboardingAnimationOne
//
//  Created by Boris on 06.09.2022.
//

import SwiftUI




struct AdaptivePagingScrollView: View {
    
    private let items: [AnyView]
    private let itemPadding: CGFloat
    private let itemSpacing: CGFloat
    private let itemScrollableSide: CGFloat
    private let itemsAmount: Int
    private let allContentLength: CGFloat
    private let visibleContentLength: CGFloat

    private let initialOffset: CGFloat
    private let scrollDampingFactor: CGFloat = 0.66
    private let orientation: Orientation

    @Binding var currentPageIndex: Int
    
    @State private var currentScrollOffset: CGFloat = 0
    @State private var gestureDragOffset: CGFloat = 0

    private func countOffset(for pageIndex: Int) -> CGFloat {
        
        let activePageOffset = CGFloat(pageIndex) * (itemScrollableSide + itemPadding)
        return initialOffset - activePageOffset
    }
    
    private func countPageIndex(for offset: CGFloat) -> Int {
        
        guard itemsAmount > 0 else { return 0 }
        
        let offset = countLogicalOffset(offset)
        let floatIndex = (offset)/(itemScrollableSide + itemPadding)
        
        var index = Int(round(floatIndex))
        if max(index, 0) > itemsAmount {
            index = itemsAmount
        }
        
        return min(max(index, 0), itemsAmount - 1)
    }
    
    private func countCurrentScrollOffset() -> CGFloat {
        return countOffset(for: currentPageIndex) + gestureDragOffset
    }
    
    private func countLogicalOffset(_ trueOffset: CGFloat) -> CGFloat {
        return (trueOffset-initialOffset) * -1.0
    }
    
    init<A: View>(currentPageIndex: Binding<Int>,
                  itemsAmount: Int,
                  itemScrollableSide: CGFloat,
                  itemPadding: CGFloat,
                  visibleContentLength: CGFloat,
                  orientation: Orientation,
                  @ViewBuilder content: () -> A) {
        
        let views = content()
        self.items = [AnyView(views)]
        
        self._currentPageIndex = currentPageIndex

        self.itemsAmount = itemsAmount
        self.itemSpacing = itemPadding
        self.itemScrollableSide = itemScrollableSide
        self.itemPadding = itemPadding
        self.visibleContentLength = visibleContentLength
        self.orientation = orientation
        self.allContentLength = (itemScrollableSide+itemPadding)*CGFloat(itemsAmount)
        
        let itemRemain = (visibleContentLength-itemScrollableSide-2*itemPadding)/2
        self.initialOffset = itemRemain + itemPadding
    }

    @ViewBuilder
    func contentView() -> some View {
        switch orientation {
        case .horizontal:
            HStack(alignment: .center, spacing: itemSpacing) {
                ForEach(items.indices, id: \.self) { itemIndex in
                    items[itemIndex].frame(width: itemScrollableSide)
                }
            }
        case .vertical:
            VStack(alignment: .leading, spacing: itemSpacing) {
                ForEach(items.indices, id: \.self) { itemIndex in
                    items[itemIndex].frame(height: itemScrollableSide)
                }
            }
        }
    }

    var body: some View {
        GeometryReader { _ in
            contentView()
        }
        .onAppear {
            currentScrollOffset = countOffset(for: currentPageIndex)
        }
        .background(Color.black.opacity(0.00001)) // hack - this allows gesture recognizing even when background is transparent
        .frameModifier(allContentLength, visibleContentLength, currentScrollOffset, orientation)
        .clipped()
        .simultaneousGesture(
            DragGesture(minimumDistance: 1, coordinateSpace: .local)
                .onChanged { value in
                    switch orientation {
                    case .horizontal:
                        gestureDragOffset = value.translation.width
                    case .vertical:
                        gestureDragOffset = value.translation.height
                    }
                    currentScrollOffset = countCurrentScrollOffset()
                }
                .onEnded { value in
                    let cleanOffset: CGFloat
                    switch orientation {
                    case .horizontal:
                        cleanOffset = (value.predictedEndTranslation.width - gestureDragOffset)
                    case .vertical:
                        cleanOffset = (value.predictedEndTranslation.height - gestureDragOffset)
                    }
                    let velocityDiff = cleanOffset * scrollDampingFactor

                    var newPageIndex = countPageIndex(for: currentScrollOffset + velocityDiff)

                    let currentItemOffset = CGFloat(currentPageIndex) * (itemScrollableSide + itemPadding)

                    if currentScrollOffset < -(currentItemOffset),
                       newPageIndex == currentPageIndex {
                        newPageIndex += 1
                    }

                    gestureDragOffset = 0

                    withAnimation(.interpolatingSpring(mass: 0.1,
                                                       stiffness: 20,
                                                       damping: 1.5,
                                                       initialVelocity: 0)) {
                        self.currentPageIndex = newPageIndex
                        self.currentScrollOffset = self.countCurrentScrollOffset()
                    }
                }
        )
    }
}
