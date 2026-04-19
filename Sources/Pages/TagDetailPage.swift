//
//  TagDetailPage.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/19.
//

import Raptor

struct TagDetailPage: Page {
    var tag: BlogTagEntry
    
    var title: String { "Tags: \(tag.name)" }
    var path: String { tag.path }
    
    @Environment(\.posts) private var posts
    
    var body: some HTML {
        let matchingPosts = posts.filter { post in
            post.tags?.contains(where: { $0.name == tag.name }) == true
        }
        
        VStack(alignment: .leading) {
            Text(tag.name)
                .font(.title1)
                .margin(.bottom, 20)
            
            List {
                ForEach(matchingPosts) { post in
                    PostListItem(post: post)
                }
            }
        }
    }
}
