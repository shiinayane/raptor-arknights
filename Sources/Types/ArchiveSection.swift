import Foundation
import Raptor

struct ArchiveSection: Identifiable, Sendable {
    let id: String
    let title: String
    let posts: [Post]
}
