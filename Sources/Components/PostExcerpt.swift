//
//  PostExcerpt.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/22.
//

import Raptor

struct PostExcerpt: HTML {
    let text: String?

    private var hasExcerpt: Bool {
        if let text {
            return !text.isEmpty
        }
        return false
    }

    var body: some HTML {
        VStack(alignment: .leading, spacing: 0) {
            if hasExcerpt {
                Divider()
                    .style(DividerStyle())

                InlineText(text ?? "")
            }
        }
        .style(PostExcerptStyle())
    }
}
