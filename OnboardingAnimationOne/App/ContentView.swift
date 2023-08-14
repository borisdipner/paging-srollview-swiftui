//
//  ContentView.swift
//  OnboardingAnimationOne
//
//  Created by Boris on 01.09.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isShowingUnitsSheet = false
    @State private var isShowingOnboardingSheet = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Paging Previews")
                .font(.system(size: 36, weight: .semibold))
                .padding(16)
            List {
                Button("Vertical", action: { isShowingUnitsSheet.toggle() })
                    .fullScreenCover(isPresented: $isShowingUnitsSheet) {
                        UnitsView(value: .constant("1"), isPresented: $isShowingUnitsSheet)
                    }
                Button("Horizontal", action: { isShowingOnboardingSheet.toggle() })
                    .fullScreenCover(isPresented: $isShowingOnboardingSheet) {
                        OnboardingView(isPresented: $isShowingOnboardingSheet)
                    }
            }
            .foregroundColor(.black)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
