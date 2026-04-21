//
//  ArknightsMetrics.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/20.
//

import Foundation

struct ArknightsMetrics {
    // MARK: - SHELL
    
    let navigationWidth: Double
    let asideWidth: Double
    
    let contentMaxWidth: Double
    let readingWidth: Double
    
    // MARK: - Spacing
    
    let sectionGap: Double
    let cardPadding: Double
    let compactSpacing: Double
    
    // MARK: - Visual
    
    let borderWidth: Double
    let cornerRadius: Double
    
    // MARK: - Post Card
    
    let postCardPaddingVertical: Int
    let postCardPaddingHorizontal: Int
    let stackedBorderOverlap: Double
}

extension ArknightsMetrics {
    static let `default` = ArknightsMetrics(
        navigationWidth: 240,
        asideWidth: 280,
        
        contentMaxWidth: 820,
        readingWidth: 720,
        
        sectionGap: 16,
        cardPadding: 16,
        compactSpacing: 8,
        
        borderWidth: 1,
        cornerRadius: 4,
        
        postCardPaddingVertical: 13,
        postCardPaddingHorizontal: 15,
        stackedBorderOverlap: -1,
    )
}
