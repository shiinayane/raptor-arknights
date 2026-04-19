//
//  TagIndexPage.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/19.
//

import Raptor

struct TagIndexPage: Page {
    let tags: [BlogTagEntry]
    
    var title = "Tags"
    var path: String { "/tags" }
    
    var body: some HTML {
        VStack(alignment: .leading) {
            Text("Tags")
                .font(.title1)
                .margin(.bottom, 20)
            
            List {
                ForEach(tags) { tag in
                    LinkGroup(destination: tag.path) {
                        Text(tag.name)
                        Text("\(tag.count) posts")
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
    }
}
