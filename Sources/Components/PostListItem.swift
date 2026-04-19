//
//  PostListItem.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/18.
//

import Foundation
import Raptor

struct PostListItem: HTML {
    let post: Post

    var body: some HTML {
        LinkGroup(destination: post) {
            VStack(alignment: .leading, spacing: 12) {
                Text(post.title)
                    .font(.title3)

                if let subtitle = post.subtitle, !subtitle.isEmpty {
                    InlineText(subtitle)
                        .foregroundStyle(.secondary)
                } else if !post.description.isEmpty {
                    InlineText(post.description)
                        .foregroundStyle(.secondary)
                }

                PostMeta(post: post)
                    .style(MetaRowStyle())
            }
            .style(PostCardStyle())
        }
    }
}
