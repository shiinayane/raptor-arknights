//
//  PageTitleStyle.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/22.
//

import Raptor

struct PageTitleStyle: Style {
    func style(content: Content, environment: EnvironmentConditions) -> Content {
        let theme = environment.arknights

        return content
            .font(.custom("SFMono"))
            .foregroundStyle(theme.palette.textPrimary)
            .style(Property.margin(.zero))
            .style(Property.paddingTop(.px(15)))
    }
}
