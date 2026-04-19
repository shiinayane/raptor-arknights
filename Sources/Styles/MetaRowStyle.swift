//
//  MetaRowStyle.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/20.
//

import Raptor

struct MetaRowStyle: Style {
    func style(content: Content, environment: EnvironmentConditions) -> Content {
        if environment.colorScheme == .dark {
            content
                .font(.system(.body))
                .foregroundStyle(Color(hex: "#9aa4b2"))
        } else {
            content
                .font(.system(.body))
                .foregroundStyle(Color(hex: "#5b6470"))
        }
    }
}
