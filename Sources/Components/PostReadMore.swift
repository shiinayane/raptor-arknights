//
//  PostReadMore.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/22.
//

import Raptor

struct PostReadMore: HTML {
    var body: some HTML {
        HStack(alignment: .center, spacing: 0) {
            Spacer()
            InlineText("READ MORE +")
                .style(ReadMoreStyle())
        }
        .style(Property.width(.percent(100)))
    }
}
