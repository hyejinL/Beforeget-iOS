//
//  BarData.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/12.
//

import Foundation

public struct Bar {
    
    // MARK: - Properties
    
    public let barTitle: String
    public let barValue: Float
    public let pinText: String

    // MARK: - Initializer
    
    public init(barTitle title: String,
         barValue value: Float,
         pinText textPin: String) {

        barTitle = title
        barValue = value
        pinText = textPin
    }
}
