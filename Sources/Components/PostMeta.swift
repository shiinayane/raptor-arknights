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

            if let tags = post.tags, !tags.isEmpty {
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

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
