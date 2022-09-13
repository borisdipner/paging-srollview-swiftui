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
    private let itemWidth: CGFloat
    private let itemsAmount: Int
    private let contentWidth: CGFloat
    
    private let leadingOffset: CGFloat
    private let scrollDampingFactor: CGFloat = 0.66
    
    @Binding var currentPageIndex: Int
    
    @State private var currentScrollOffset: CGFloat = 0
    @State private var gestureDragOffset: CGFloat = 0
        
    private func countOffset(for pageIndex: Int) -> CGFloat {
        
        let activePageOffset = CGFloat(pageIndex) * (itemWidth + itemPadding)
        return leadingOffset - activePageOffset
    }
    
    private func countPageIndex(for offset: CGFloat) -> Int {
        
        guard itemsAmount > 0 else { return 0 }
        
        let offset = countLogicalOffset(offset)
        let floatIndex = (offset)/(itemWidth + itemPadding)
        
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
        return (trueOffset-leadingOffset) * -1.0
    }
    
    init<A: View>(currentPageIndex: Binding<Int>,
                  itemsAmount: Int,
                  itemWidth: CGFloat,
                  itemPadding: CGFloat,
                  pageWidth: CGFloat,
                  @ViewBuilder content: () -> A) {
        
        let views = content()
        self.items = [AnyView(views)]
        
        self._currentPageIndex = currentPageIndex
         
        self.itemsAmount = itemsAmount
        self.itemSpacing = itemPadding
        self.itemWidth = itemWidth
        self.itemPadding = itemPadding
        self.contentWidth = (itemWidth+itemPadding)*CGFloat(itemsAmount)
        
        let itemRemain = (pageWidth-itemWidth-2*itemPadding)/2
        self.leadingOffset = itemRemain + itemPadding
    }
    
    
    var body: some View {
        GeometryReader { viewGeometry in
            HStack(alignment: .center, spacing: itemSpacing) {
                ForEach(items.indices, id: \.self) { itemIndex in
                    items[itemIndex].frame(width: itemWidth)
                }
            }
        }
        .onAppear {
            currentScrollOffset = countOffset(for: currentPageIndex)
        }
        .background(Color.black.opacity(0.00001)) // hack - this allows gesture recognizing even when background is transparent
        .frame(width: contentWidth)
        .offset(x: self.currentScrollOffset, y: 0)
        .simultaneousGesture(
            DragGesture(minimumDistance: 1, coordinateSpace: .local)
                .onChanged { value in
                    gestureDragOffset = value.translation.width
                    currentScrollOffset = countCurrentScrollOffset()
                }
                .onEnded { value in
                    let cleanOffset = (value.predictedEndTranslation.width - gestureDragOffset)
                    let velocityDiff = cleanOffset * scrollDampingFactor
                    
                    var newPageIndex = countPageIndex(for: currentScrollOffset + velocityDiff)
                    
                    let currentItemOffset = CGFloat(currentPageIndex) * (itemWidth + itemPadding)
                    
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
