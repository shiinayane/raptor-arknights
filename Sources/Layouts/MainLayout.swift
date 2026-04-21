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

        Main {
            content
        }

        Footer {
            RaptorFooter()
        }
    }
}
