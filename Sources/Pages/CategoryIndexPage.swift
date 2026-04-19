//
//  CategoryIndexPage.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/19.
//

import Raptor

struct CategoryIndexPage: Page {
    let categories: [BlogCategoryEntry]
    
    var title = "Categories"
    var path: String { "/categories" }
    
    var body: some HTML {
        VStack(alignment: .leading) {
            Text("Categories")
                .font(.title1)
                .margin(.bottom, 20)
            
            List {
                ForEach(categories) { category in
                    LinkGroup(destination: category.path) {
                        Text(category.name)
                        Text("\(category.count) posts")
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
    }
}
