import Foundation
import Raptor

struct SiteHeader: HTML {
    @Environment(\.site) private var site

    var body: some HTML {
        HStack(alignment: .center, spacing: .medium) {
            VStack(alignment: .leading, spacing: 4) {
                InlineText(site.name)
                    .font(.title3)
                    .fontWeight(.bold)
                    .navigationItemRole(.logo)

                if let description = site.description, !description.isEmpty {
                    InlineText(description)
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()

            HStack(alignment: .center, spacing: .medium) {
                LinkGroup(destination: ArchivePage().path) {
                    InlineText("Archives")
                }
            }
        }
    }
}
