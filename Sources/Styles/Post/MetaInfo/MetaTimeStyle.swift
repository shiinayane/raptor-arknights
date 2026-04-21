//
//  MetaTimeStyle.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/21.
//

import Raptor

struct MetaTimeStyle: Style {
    func style(content: Content, environment: EnvironmentConditions) -> Content {
        let theme = environment.arknights

        return content
            .font(.custom("BenderLight"))
            .foregroundStyle(theme.palette.textMuted)
            .style(Property.display(.inlineBlock))
    }
}
