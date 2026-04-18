import Foundation

struct BlogCategoryEntry: Identifiable, Equatable, Sendable {
    let name: String
    let slug: String
    let sourceFolder: String
    let count: Int

    var id: String { slug }
    var path: String { "/categories/\(slug)" }
}
