import Foundation

struct BlogTagEntry: Identifiable, Equatable, Sendable {
    let name: String
    let slug: String
    let count: Int

    var id: String { slug }
    var path: String { "/tags/\(slug)" }
}
