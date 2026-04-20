//
//  TaxonomyPillStyle.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/20.
//

import Raptor

struct TaxonomyPillStyle: Style {
    func style(content: Content, environment: EnvironmentConditions) -> Content {
        if environment.colorScheme == .dark {
            return content
                .font(.system(.body))
                .background(Color(hex: "#202632"))
                .foregroundStyle(Color(hex: "#c9d2df"))
                .border(Color(hex: "#344055"), width: 1)
                .cornerRadius(999)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
        } else {
            return content
                .font(.system(.body))
                .background(Color(hex: "#eef3f8"))
                .foregroundStyle(Color(hex: "#415063"))
                .border(Color(hex: "#d3dce6"), width: 1)
                .cornerRadius(999)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
        }
    }
}
