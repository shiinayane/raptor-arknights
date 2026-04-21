//
//  PostListItem.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/18.
//

import Raptor

struct PostListItem: HTML {
    let post: Post

    var body: some HTML {
        LinkGroup(destination: post) {
            VStack(alignment: .leading, spacing: 12) {
                PostMeta(post: post)

                Text(post.title)
                    .font(.title3)

                if let subtitle = post.subtitle, !subtitle.isEmpty {
                    InlineText(subtitle)
                        .foregroundStyle(.secondary)
                } else if !post.description.isEmpty {
                    InlineText(post.description)
                        .foregroundStyle(.secondary)
                }

                // TODO: Add sticky badge support near the title.
                // TODO: Add a dedicated excerpt block style if needed.
                // TODO: Add a read-more element matching the original theme.
            }
            .style(PostCardStyle())
        }
    }
}
