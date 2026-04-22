//
//  PostExcerptStyle.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/22.
//

import Raptor

struct PostExcerptStyle: Style {
    func style(content: Content, environment: EnvironmentConditions) -> Content {
        content
            .style(Property.marginTop(.px(12)))
            .style(Property.marginBottom(.px(28)))
    }
}
