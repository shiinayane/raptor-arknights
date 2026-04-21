//
//  PostsListStyle.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/22.
//

import Raptor

struct PostsListStyle: Style {
    func style(content: Content, environment: EnvironmentConditions) -> Content {
        content
            .style(Property.width(.percent(100)))
            .style(Property.marginTop(.px(10)))
            .style(Property.paddingBottom(.px(72)))
    }
}
