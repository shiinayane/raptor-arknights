//
//  CategoryLabelStyle.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/21.
//

import Raptor

struct CategoryLabelStyle: Style {
    func style(content: Content, environment: EnvironmentConditions) -> Content {
        let theme = environment.arknights

        return content
            .font(.custom("BenderLight", size: theme.typography.largeSize, weight: .bold))
            .foregroundStyle(theme.palette.accent)
            .style(Property.paddingRight(.px(10)))
    }
}
