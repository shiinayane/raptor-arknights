//
//  ArknightsTheme.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/19.
//

import Raptor

struct ArknightsTheme: Theme {
    func theme(site: Content, colorScheme: ColorScheme) -> Content {
        let base = site
            // Typography
            .font(.system(.body))
            .titleFont(.system(.title1))

            .fontSize(36, for: .title1)
            .fontWeight(.semibold, for: .title1)

            .fontSize(28, for: .title2)
            .fontWeight(.semibold, for: .title2)

            .fontSize(22, for: .title3)
            .fontWeight(.medium, for: .title3)

            .fontSize(16, for: .body)
            .lineSpacing(1.7, for: .body)

            .fontSize(14, for: .codeBlock)
            .lineSpacing(1.6, for: .codeBlock)

            // Layout
            .contentWidth(max: 820)

        let themed = base
        
        if colorScheme == .dark {
            return themed
                .accent(Color(hex: "#4da3ff"))
                .foregroundStyle(Color(hex: "#e6e8eb"))
                .background(Color(hex: "#0f1115"))
        } else {
            return themed
                .accent(Color(hex: "#2563eb"))
                .foregroundStyle(Color(hex: "#1a1a1a"))
                .background(Color(hex: "#ffffff"))
        }
    }
}
