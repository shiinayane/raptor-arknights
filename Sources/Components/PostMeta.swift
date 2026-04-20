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
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center, spacing: .small) {
                InlineText(Self.dateFormatter.string(from: post.date))
                    .foregroundStyle(.secondary)
                
                InlineText("·")
                    .foregroundStyle(.secondary)
                
                InlineText("\(post.estimatedReadingMinutes) min read")
                    .foregroundStyle(.secondary)
            }
            .style(MetaRowStyle())
            
            if hasCategory || !visibleTags.isEmpty {
                HStack(alignment: .center, spacing: .small) {
                    if hasCategory {
                        Link(displayName(from: post.type), destination: categoryPath(from: post.type))
                            .style(TaxonomyPillStyle())
                    }
                    
                    if !visibleTags.isEmpty {
                        if hasCategory {
                            InlineText("·")
                                .foregroundStyle(.secondary)
                        }
                        
                        HStack(alignment: .center, spacing: .small) {
                            ForEach(visibleTags) { tag in
                                Link(tag.name, destination: tag.path)
                                    .style(TaxonomyPillStyle())
                            }
                        }
                    }
                }
                .style(MetaRowStyle())
            }
        }
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
