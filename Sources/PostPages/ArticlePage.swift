//
//  ArticlePage.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/18.
//

import Foundation
import Raptor

struct ArticlePage: PostPage {
    @Environment(\.posts) private var posts

    var body: some HTML {
        VStack(alignment: .leading, spacing: 24) {
            Text(post.title)
                .font(.title1)

            if let subtitle = post.subtitle, !subtitle.isEmpty {
                Text(subtitle)
                    .font(.title3)
            }

            PostMeta(post: post)

            post.text
                .definitionGroupIndent(.scaled(2.75))

            navigation
        }
    }

    private var navigation: some HTML {
        HStack(alignment: .center, spacing: .large) {
            if let previousPost {
                navigationLink(post: previousPost, label: "Previous")
            }

            Spacer()

            if let nextPost {
                navigationLink(post: nextPost, label: "Next")
            }
        }
    }

    private func navigationLink(post: Post, label: String) -> some HTML {
        LinkGroup(destination: post) {
            VStack(alignment: .leading, spacing: 4) {
                InlineText(label)
                    .foregroundStyle(.secondary)

                Text(post.title)
                    .font(.title3)
            }
        }
    }

    private var currentPostIndex: Int? {
        posts.firstIndex { $0.path == post.path }
    }

    private var previousPost: Post? {
        guard let currentPostIndex, currentPostIndex > 0 else {
            return nil
        }

        return posts[currentPostIndex - 1]
    }

    private var nextPost: Post? {
        guard let currentPostIndex, currentPostIndex < posts.count - 1 else {
            return nil
        }

        return posts[currentPostIndex + 1]
    }
}
