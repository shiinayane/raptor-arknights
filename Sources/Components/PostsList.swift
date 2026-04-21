//
//  PostsList.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/22.
//

import Raptor

struct PostsList: HTML {
    let posts: PostCollection
    
    var body: some HTML {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(posts) { post in
                PostListItem(post: post)
            }
        }
        .style(PostsListStyle())
    }
}
