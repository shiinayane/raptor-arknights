//
//  CategoryDetailPage.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/19.
//

import Raptor

struct CategoryDetailPage: Page {
    var category: BlogCategoryEntry
    
    var title: String { "Categories: \(category.name)" }
    var path: String { category.path }
    
    @Environment(\.posts) private var posts
    
    var body: some HTML {
        let matchingPosts = posts.filter {
            $0.type == category.sourceFolder
        }
        
        VStack(alignment: .leading) {
            Text(category.name)
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
