//
//  ThemeTokens.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/19.
//

import Foundation

enum ThemeTokens {
    enum Layout {
        static let contentMaxWidth: Double = 960
        static let articleMaxWidth: Double = 760
    }

    enum Spacing {
        static let pageTop: Double = 32
        static let pageBottom: Double = 72
        static let sectionGap: Double = 24
        static let cardPadding: Double = 20
        static let blockGap: Double = 16
    }

    enum Shape {
        static let panelRadius: Double = 14
        static let borderWidth: Double = 1
    }

    enum Typography {
        static let heroTitleSize: Double = 40
        static let pageTitleSize: Double = 32
        static let sectionTitleSize: Double = 24
        static let bodySize: Double = 16
        static let metaSize: Double = 13
    }

    enum Tone {
        static let pageBackgroundName = "page-background"
        static let panelBackgroundName = "panel-background"
        static let borderName = "panel-border"
        static let primaryTextName = "text-primary"
        static let secondaryTextName = "text-secondary"
        static let accentName = "accent"
    }
}
