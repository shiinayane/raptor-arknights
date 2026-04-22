//
//  PostListItem.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/18.
//

import Raptor

struct PostListItem: HTML {
    let post: Post

    private var excerptText: String? {
        if let subtitle = post.subtitle, !subtitle.isEmpty {
            return subtitle
        } else {
            return nil
        }
    }
    
    var body: some HTML {
        VStack(alignment: .leading, spacing: 12) {
            PostMeta(post: post)

            Link(post.title, destination: post.path)
                .font(.title1)
                .style(PageTitleStyle())

            PostExcerpt(text: excerptText)

            HStack(alignment: .center, spacing: 0) {
                Spacer()
                Link("READ MORE +", destination: post.path)
                    .style(ReadMoreStyle())
            }
            .style(Property.width(.percent(100)))
        }
        .style(PostCardStyle())
    }
}
