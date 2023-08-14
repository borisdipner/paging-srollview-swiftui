//
//  UnitRowsData.swift
//  OnboardingAnimationOne
//
//  Created by Mariya Pankova on 18.07.2023.
//

import Foundation

class UnitRowsData: ObservableObject {

    let units: [UnitRow]

    var primary: UnitRow {
        units.first!
    }

    init() {
        units = [
            .init(unit: "kg", unitName: "Kilogram"),
            .init(unit: "g", unitName: "Gram"),
            .init(unit: "mg", unitName: "Miligram"),
            .init(unit: "lb", unitName: "Pound"),
        ]
    }
}
