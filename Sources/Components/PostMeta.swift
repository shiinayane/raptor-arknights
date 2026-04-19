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

            HStack(alignment: .center, spacing: .small) {
                if !post.type.isEmpty {
                    Link(displayName(from: post.type), destination: categoryPath(from: post.type))
                        .foregroundStyle(.secondary)
                }
                
                if let tags = post.tags, !tags.isEmpty {
                    InlineText("·")
                        .foregroundStyle(.secondary)
                    
                    HStack(alignment: .center, spacing: .small) {
                        ForEach(tags) { tag in
                            LinkGroup(destination: tag.path) {
                                InlineText(tag.name)
                            }
                        }
                    }
                }
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
