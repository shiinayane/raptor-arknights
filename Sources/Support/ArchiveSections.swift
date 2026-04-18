import Foundation
import Raptor

enum ArchiveSections {
    static func make(from posts: [Post]) -> [ArchiveSection] {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM"

        let grouped = Dictionary(grouping: posts) { post in
            formatter.string(from: post.date)
        }

        return grouped
            .map { key, groupedEntries in
                ArchiveSection(
                    id: key,
                    title: key,
                    posts: groupedEntries.sorted { $0.date > $1.date }
                )
            }
            .sorted { $0.id > $1.id }
    }
}
