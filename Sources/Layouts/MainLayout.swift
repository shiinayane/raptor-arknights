//
//  MainLayout.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/18.
//

import Raptor

struct MainLayout: Layout {
    var body: some Document {
        Navigation {
            SiteHeader()
        }
        .margin(.vertical, 20)
        .navigationBarSizing(.contentArea)

        Main {
            content
        }

        Footer {
            RaptorFooter()
        }
    }
}
