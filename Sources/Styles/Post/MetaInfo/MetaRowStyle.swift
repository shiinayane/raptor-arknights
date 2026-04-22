//
//  MetaRowStyle.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/20.
//

import Raptor

struct MetaRowStyle: Style {
    func style(content: Content, environment: EnvironmentConditions) -> Content {
        let theme = environment.arknights

        return content
            .foregroundStyle(theme.palette.textMuted)
    }
}
