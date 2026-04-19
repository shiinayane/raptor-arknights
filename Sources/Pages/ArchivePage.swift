import Foundation
import Raptor

struct ArchivePage: Page {
    var title = "Archives"
    var path = "/archives"

    @Environment(\.posts) private var posts

    var body: some HTML {
        VStack(alignment: .leading, spacing: 24) {
            Text("Archives")
                .font(.title1)

            let sections = Self.makeSections(for: Array(posts))

            if sections.isEmpty {
                Text("No posts yet.")
            } else {
                VStack(alignment: .leading, spacing: 32) {
                    ForEach(sections) { section in
                        VStack(alignment: .leading, spacing: 18) {
                            Text(section.title)
                                .font(.title2)

                            VStack(alignment: .leading, spacing: 18) {
                                ForEach(section.posts) { post in
                                    PostListItem(post: post)
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    static func makeSections(for posts: [Post]) -> [ArchiveSection] {
        ArchiveSections.make(from: posts)
    }
}
