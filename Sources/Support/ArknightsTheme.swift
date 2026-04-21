//
//  ArknightsTheme.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/19.
//

import Raptor

struct ArknightsTheme {
    let palette: ArknightsPalette
    let metrics: ArknightsMetrics
    let typography: ArknightsTypography
}

extension ArknightsTheme {
    static let dark = ArknightsTheme(
        palette: .dark,
        metrics: .default,
        typography: .default
    )
    
    static let light = ArknightsTheme(
        palette: .light,
        metrics: .default,
        typography: .default
    )
    
    static func resolve(from environment: EnvironmentConditions) -> ArknightsTheme {
        guard let scheme = environment.colorScheme else {
            return .dark
        }
        
        switch scheme {
        case .dark:
            return .dark
        case .light:
            return .light
        }
    }
}

extension EnvironmentConditions {
    var arknights: ArknightsTheme {
        ArknightsTheme.resolve(from: self)
    }
}
