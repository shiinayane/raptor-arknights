//
//  ArknightsSiteTheme.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/21.
//

import Raptor

struct ArknightsSiteTheme: Theme {
    func theme(site: Content, colorScheme: ColorScheme) -> Content {
        site
            .font(.custom("JetBrainsMono"))
    }
}
