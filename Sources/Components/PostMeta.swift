//
//  PostMeta.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/18.
//

import Foundation
import Raptor

struct PostMeta: HTML {
    let post: Post
    
    private var hasCategory: Bool {
        !post.type.isEmpty
    }
    
    private var visibleTags: [TagMetadata] {
        post.tags ?? []
    }

    var body: some HTML {
        HStack(alignment: .bottom, spacing: 0) {
            HStack(alignment: .bottom, spacing: 0) {
                if hasCategory {
                    Link(displayName(from: post.type), destination: categoryPath(from: post.type))
                        .style(CategoryLabelStyle())
                }

                if !visibleTags.isEmpty {
                    HStack(alignment: .center, spacing: .small) {
                        ForEach(visibleTags) { tag in
                            Link(tag.name, destination: tag.path)
                                .style(TagLabelStyle())
                        }
                    }
                }
            }
            
            Spacer()
            
            InlineText(Self.dateFormatter.string(from: post.date))
                .style(MetaTimeStyle())
        }
        .style(Property.width(.percent(100)))
        .style(MetaRowStyle())
    }

    private func displayName(from folder: String) -> String {
        folder
            .split(separator: "-")
            .map { $0.prefix(1).uppercased() + $0.dropFirst() }
            .joined(separator: " ")
    }

    private func categoryPath(from folder: String) -> String {
        "/categories/\(folder.lowercased().replacingOccurrences(of: " ", with: "-"))"
    }

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
