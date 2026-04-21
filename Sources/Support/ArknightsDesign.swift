//
//  ArknightsDesign.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/19.
//

import Raptor

struct ArknightsDesign {
    let palette: ArknightsPalette
    let metrics: ArknightsMetrics
    let typography: ArknightsTypography
}

extension ArknightsDesign {
    static let dark = ArknightsDesign(
        palette: .dark,
        metrics: .default,
        typography: .default
    )
    
    static let light = ArknightsDesign(
        palette: .light,
        metrics: .default,
        typography: .default
    )
    
    static func resolve(from environment: EnvironmentConditions) -> ArknightsDesign {
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
    var arknights: ArknightsDesign {
        ArknightsDesign.resolve(from: self)
    }
}
