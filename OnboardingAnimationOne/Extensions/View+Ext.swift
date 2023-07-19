//
//  View+Ext.swift
//  OnboardingAnimationOne
//
//  Created by Mariya Pankova on 19.07.2023.
//

import SwiftUI

extension View {
    func frameModifier(_ contentLength: CGFloat,
                       _ visibleContentLength: CGFloat,
                       _ currentScrollOffset: CGFloat,
                       _ orientation: Orientation) -> some View {
        modifier(
            FrameModifier(
                contentLength: contentLength,
                visibleContentLength: visibleContentLength,
                currentScrollOffset: currentScrollOffset,
                orientation: orientation
            )
        )
    }
}
