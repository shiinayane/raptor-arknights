//
//  Site.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/18.
//

import Foundation
import Raptor

@main
struct RaptorWebsite {
    static func main() async {
        var site = Arknights()

        do {
            try await site.publish()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct Arknights: Site {
    var name = "My Blog"
    var titleSuffix = " – My Awesome Site"
    var url = URL(static: "https://www.shiinayane.com")

    var author = "shiinayane"

    var discoveredTags: [BlogTagEntry] = []
    var discoveredCategories: [BlogCategoryEntry] = []

    var homePage = Home()
    var layout = MainLayout()
    var pages: [any Page] {
        [
            ArchivePage(),
            TagIndexPage(tags: discoveredTags),
            CategoryIndexPage(categories: discoveredCategories)
        ]
        + discoveredTags.map(TagDetailPage.init)
        + discoveredCategories.map(CategoryDetailPage.init)
    }
    var postPages: [any PostPage] {
        ArticlePage()
    }

    mutating func prepare() async throws {
        let postsDirectory = Self.packageRoot.appending(path: "Posts")

        let markdownFiles = FileManager.default.enumerator(
            at: postsDirectory,
            includingPropertiesForKeys: nil
        )?
        .compactMap { $0 as? URL }
        .filter { $0.pathExtension == "md" } ?? []

        let documents = try markdownFiles.map { fileURL in
            let markdown = try String(contentsOf: fileURL, encoding: .utf8)
            let relativePath = fileURL.path.replacingOccurrences(of: postsDirectory.path + "/", with: "")
            return BlogContentDiscovery.parse(relativePath: relativePath, markdown: markdown)
        }

        discoveredTags = BlogContentDiscovery.tagEntries(from: documents)
        discoveredCategories = BlogContentDiscovery.categoryEntries(from: documents)
    }

    private static let packageRoot: URL = {
        URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
    }()
}
