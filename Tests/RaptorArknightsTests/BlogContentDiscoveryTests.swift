//
//  BlogContentDiscoveryTests.swift
//  RaptorArknights
//
//  Created by 椎名アヤネ on 2026/04/18.
//

import XCTest
@testable import RaptorArknights
@testable import Raptor

final class BlogContentDiscoveryTests: XCTestCase {
    func testParseTagsReadsCommaSeparatedFrontMatter() {
        let markdown = """
        ---
        title: Sample
        tags: swift, raptor, arknights
        ---
        Hello
        """

        let document = BlogContentDiscovery.parse(
            relativePath: "notes/welcome.md",
            markdown: markdown
        )

        XCTAssertEqual(document.categoryFolder, "notes")
        XCTAssertEqual(document.tags, ["swift", "raptor", "arknights"])
    }

    func testParseTagsReadsYAMLListFrontMatter() {
        let markdown = """
        ---
        title: Sample
        tags:
          - swift
          - raptor
        ---
        Hello
        """

        let document = BlogContentDiscovery.parse(
            relativePath: "Posts/notes/list.md",
            markdown: markdown
        )

        XCTAssertEqual(document.tags, ["swift", "raptor"])
    }

    func testParseTagsReadsFrontMatterWithCRLFDelimiters() {
        let markdown = "---\r\ntitle: Sample\r\ntags: swift, raptor\r\n---\r\nHello\r\n"

        let document = BlogContentDiscovery.parse(
            relativePath: "Posts/notes/crlf.md",
            markdown: markdown
        )

        XCTAssertEqual(document.tags, ["swift", "raptor"])
    }

    func testBodyDelimiterDoesNotCreateFrontMatterWhenMissingLeadingBlock() {
        let markdown = """
        Intro text.
        ---
        tags: should-not-parse
        ---
        Outro text.
        """

        let document = BlogContentDiscovery.parse(
            relativePath: "Posts/notes/body-only.md",
            markdown: markdown
        )

        XCTAssertEqual(document.categoryFolder, "notes")
        XCTAssertEqual(document.tags, [])
    }

    func testTagEntriesDeduplicateByDocumentMembershipAndNormalizeSlug() {
        let documents = [
            BlogSourceDocument(
                relativePath: "Posts/notes/a.md",
                categoryFolder: "notes",
                tags: ["Swift", "swift", "raptor"]
            ),
            BlogSourceDocument(
                relativePath: "Posts/devlog/b.md",
                categoryFolder: "devlog",
                tags: ["swift", "raptor"]
            )
        ]

        let entries = BlogContentDiscovery.tagEntries(from: documents)

        XCTAssertEqual(entries.count, 2)
        XCTAssertEqual(entries[0].slug, "raptor")
        XCTAssertEqual(entries[0].count, 2)
        XCTAssertEqual(entries[1].slug, "swift")
        XCTAssertEqual(entries[1].count, 2)
        XCTAssertEqual(entries[1].path, "/tags/swift")
    }

    func testCategoryEntriesNormalizeSlugCollisions() {
        let documents = [
            BlogContentDiscovery.parse(
                relativePath: "Posts/foo bar/a.md",
                markdown: """
                ---
                title: A
                ---
                body
                """
            ),
            BlogContentDiscovery.parse(
                relativePath: "Posts/foo_bar/b.md",
                markdown: """
                ---
                title: B
                ---
                body
                """
            )
        ]

        let entries = BlogContentDiscovery.categoryEntries(from: documents)

        XCTAssertEqual(entries.count, 1)
        XCTAssertEqual(entries[0].slug, "foo-bar")
        XCTAssertEqual(entries[0].count, 2)
        XCTAssertEqual(entries[0].path, "/categories/foo-bar")
    }

    func testTagEntriesAggregateCounts() {
        let documents = [
            BlogSourceDocument(
                relativePath: "notes/a.md",
                categoryFolder: "notes",
                tags: ["swift", "raptor"]
            ),
            BlogSourceDocument(
                relativePath: "devlog/b.md",
                categoryFolder: "devlog",
                tags: ["raptor"]
            )
        ]

        XCTAssertEqual(
            BlogContentDiscovery.tagEntries(from: documents),
            [
                BlogTagEntry(name: "raptor", slug: "raptor", count: 2),
                BlogTagEntry(name: "swift", slug: "swift", count: 1)
            ]
        )
    }

    func testCategoryEntriesUseFirstFolderUnderPosts() {
        let documents = [
            BlogContentDiscovery.parse(
                relativePath: "Posts/notes/a.md",
                markdown: """
                ---
                title: A
                ---
                body
                """
            ),
            BlogContentDiscovery.parse(
                relativePath: "Posts/notes/b.md",
                markdown: """
                ---
                title: B
                ---
                body
                """
            ),
            BlogContentDiscovery.parse(
                relativePath: "Posts/devlog/c.md",
                markdown: """
                ---
                title: C
                ---
                body
                """
            )
        ]

        XCTAssertEqual(documents.map(\.categoryFolder), ["notes", "notes", "devlog"])

        XCTAssertEqual(
            BlogContentDiscovery.categoryEntries(from: documents),
            [
                BlogCategoryEntry(
                    name: "Devlog",
                    slug: "devlog",
                    sourceFolder: "devlog",
                    count: 1
                ),
                BlogCategoryEntry(
                    name: "Notes",
                    slug: "notes",
                    sourceFolder: "notes",
                    count: 2
                )
            ]
        )
    }

    func testArchiveSectionsGroupPostsByYearMonth() {
        let april = makePost(title: "April", date: date("2026-04-18T00:00:00Z"))
        let march = makePost(title: "March", date: date("2026-03-01T00:00:00Z"))

        let sections = ArchiveSections.make(from: [march, april])

        XCTAssertEqual(sections.count, 2)
        XCTAssertEqual(sections[0].id, "2026-04")
        XCTAssertEqual(sections[0].title, "2026-04")
        XCTAssertEqual(sections[0].posts.first?.title, "April")
        XCTAssertEqual(sections[1].id, "2026-03")
        XCTAssertEqual(sections[1].title, "2026-03")
        XCTAssertEqual(sections[1].posts.first?.title, "March")
    }

    func testArchiveSectionsSortPostsWithinMonthByNewestFirst() {
        let early = makePost(title: "Early", date: date("2026-04-01T00:00:00Z"))
        let late = makePost(title: "Late", date: date("2026-04-18T00:00:00Z"))

        let sections = ArchivePage.makeSections(for: [early, late])

        XCTAssertEqual(sections.count, 1)
        XCTAssertEqual(sections[0].id, "2026-04")
        XCTAssertEqual(sections[0].posts.map(\.title), ["Late", "Early"])
    }

    func testArchivePagePathUsesArchivesRoute() {
        XCTAssertEqual(ArchivePage().path, "/archives")
    }

    func testSitePagesIncludeArchivesRouteAndExcludeArchiveRoute() {
        let pages = Arknights().pages

        XCTAssertTrue(pages.contains { $0.path == ArchivePage().path })
        XCTAssertFalse(pages.contains { $0.path == "/archive" })
    }

    private func date(_ string: String) -> Date {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: string)!
    }

    private func makePost(title: String, date: Date) -> Post {
        var post = Post()
        post.title = title
        post.metadata["date"] = date
        return post
    }
}
