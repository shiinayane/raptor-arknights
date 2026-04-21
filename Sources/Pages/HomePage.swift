//
//  HomePage.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/18.
//

import Foundation
import Raptor

struct HomePage: Page {
    var title = "Home"

    @Environment(\.posts) private var posts

    var body: some HTML {
        VStack(alignment: .leading, spacing: 24) {
            Text("Posts")
                .font(.title1)

            if posts.isEmpty {
                Text("No posts yet.")
            } else {
                PostsList(posts: posts)
            }
        }
    }
}
