//
//  TagLabelStyle.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/21.
//

import Raptor

struct TagLabelStyle: Style {
    func style(content: Content, environment: EnvironmentConditions) -> Content {
        let theme = environment.arknights

        return content
            .style(Property.fontSize(.px(theme.typography.smallSize)))
            .style(Property.display(.inlineBlock))
            .style(Property.paddingRight(.px(5)))
    }
}
