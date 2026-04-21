//
//  ArknightsTypography.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/20.
//

import Raptor

struct ArknightsTypography {
    // MARK: - Base Text

    let bodySize: Double
    let bodyLineHeight: Double

    let smallSize: Double
    let smallLineHeight: Double

    let mediumSize: Double
    let largeSize: Double

    let codeSize: Double
    let codeLineHeight: Double

    // MARK: - Headings

    let title1Size: Double
    let title1Weight: Font.Weight

    let title2Size: Double
    let title2Weight: Font.Weight

    let title3Size: Double
    let title3Weight: Font.Weight

    let title4Size: Double
    let title4Weight: Font.Weight

    let title5Size: Double
    let title5Weight: Font.Weight

    let title6Size: Double
    let title6Weight: Font.Weight
}

extension ArknightsTypography {
    static let `default` = ArknightsTypography(
        bodySize: 16,
        bodyLineHeight: 1.7,

        smallSize: 13,
        smallLineHeight: 1.5,

        mediumSize: 14,
        largeSize: 16,

        codeSize: 14,
        codeLineHeight: 1.6,

        title1Size: 36,
        title1Weight: .semibold,

        title2Size: 28,
        title2Weight: .semibold,

        title3Size: 22,
        title3Weight: .medium,

        title4Size: 18,
        title4Weight: .medium,

        title5Size: 16,
        title5Weight: .medium,
        
        title6Size: 14,
        title6Weight: .medium
    )
}
