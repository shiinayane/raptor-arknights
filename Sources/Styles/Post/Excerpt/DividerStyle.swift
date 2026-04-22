//
//  DividerStyle.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/22.
//

import Raptor

struct DividerStyle: Style {
    func style(content: Content, environment: EnvironmentConditions) -> Content {
        let theme = environment.arknights

        return content
            .style(Property.width(.percent(100)))
            .foregroundStyle(theme.palette.textMuted)
            .border(theme.palette.textMuted)
    }
}
