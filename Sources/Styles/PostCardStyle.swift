//
//  PostCardStyle.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/20.
//

import Raptor

struct PostCardStyle: Style {
    func style(content: Content, environment: EnvironmentConditions) -> Content {
        if environment.colorScheme == .dark {
            content
                .background(Color(hex: "#171b22"))
                .border(Color(hex: "#2a313c"), width: 1)
                .cornerRadius(14)
                .padding(20)
        } else {
            content
                .background(Color(hex: "#f7f9fc"))
                .border(Color(hex: "#d9e0e8"), width: 1)
                .cornerRadius(14)
                .padding(20)
        }
    }
}
