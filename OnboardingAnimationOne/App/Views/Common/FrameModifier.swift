//
//  FrameModifier.swift
//  OnboardingAnimationOne
//
//  Created by Mariya Pankova on 19.07.2023.
//

import SwiftUI

struct FrameModifier: ViewModifier {
    let contentLength: CGFloat
    let visibleContentLength: CGFloat
    let currentScrollOffset: CGFloat
    let orientation: Orientation

    init (contentLength: CGFloat,
          visibleContentLength: CGFloat,
          currentScrollOffset: CGFloat,
          orientation: Orientation) {
        self.contentLength = contentLength
        self.visibleContentLength = visibleContentLength
        self.currentScrollOffset = currentScrollOffset
        self.orientation = orientation
    }

    func body(content: Content) -> some View {
        switch orientation {
        case .horizontal:
            return content
                .frame(width: contentLength)
                .offset(x: self.currentScrollOffset, y: 0)
        case .vertical:
            return content
                .frame(height: visibleContentLength)
                .offset(x: 0, y: self.currentScrollOffset)
        }
    }
}
