//
//  InfoAccentBarStyle.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/22.
//

import Raptor

struct InfoAccentBarStyle: Style {
    func style(content: Content, environment: EnvironmentConditions) -> Content {
        let theme = environment.arknights

        return content
            .style(Property.width(.percent(13)))
            .style(Property.height(.px(5)))
            .background(theme.palette.accent)
            .style(Property.marginTop(.px(6))) // 等价 bottom: -6px
    }
}
