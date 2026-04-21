//
//  PostCardStyle.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/20.
//

import Raptor

struct PostCardStyle: Style {
    func style(content: Content, environment: EnvironmentConditions) -> Content {
        let theme = environment.arknights
        
        return content
            .background(theme.palette.surfaceSoft)
            .foregroundStyle(theme.palette.textMuted)
            .border(theme.palette.textMuted, width: 1)
            .padding(.vertical, theme.metrics.postCardPaddingVertical)
            .padding(.horizontal, theme.metrics.postCardPaddingHorizontal)
    }
}
