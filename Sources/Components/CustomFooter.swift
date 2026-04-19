//
//  CustomFooter.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/19.
//

import Foundation
import Raptor

struct CustomFooter: HTML {
    var body: some HTML {
        Group {
            Text {
                "Theme Arknights by "
                Link("shiinayane", destination: URL(static: "https://www.shiinayane.com"))
            }
            Text {
                "Created in Swift with "
                Link("Raptor", destination: URL(static: "https://raptor.build"))
            }
        }
        .multilineTextAlignment(.center)
        .margin(.top, .xLarge)
    }
}
