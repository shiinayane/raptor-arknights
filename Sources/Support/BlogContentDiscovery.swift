import Foundation

struct BlogSourceDocument: Equatable, Sendable {
    let relativePath: String
    let categoryFolder: String?
    let tags: [String]
}

enum BlogContentDiscovery {
    static func parse(relativePath: String, markdown: String) -> BlogSourceDocument {
        BlogSourceDocument(
            relativePath: relativePath,
            categoryFolder: categoryFolder(for: relativePath),
            tags: parseTags(from: markdown)
        )
    }

    static func tagEntries(from documents: [BlogSourceDocument]) -> [BlogTagEntry] {
        let counts = documents.reduce(into: [String: TagAccumulator]()) { result, document in
            var seenTags = Set<String>()

            for rawTag in document.tags {
                let key = slugify(rawTag)
                guard seenTags.insert(key).inserted else { continue }

                if var accumulator = result[key] {
                    accumulator.count += 1
                    result[key] = accumulator
                } else {
                    result[key] = TagAccumulator(name: rawTag.trimmingCharacters(in: .whitespacesAndNewlines), count: 1)
                }
            }
        }

        return counts
            .map { key, accumulator in
                BlogTagEntry(
                    name: accumulator.name,
                    slug: key,
                    count: accumulator.count
                )
            }
            .sorted {
                $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
            }
    }

    static func categoryEntries(from documents: [BlogSourceDocument]) -> [BlogCategoryEntry] {
        let counts = documents.reduce(into: [String: CategoryAccumulator]()) { result, document in
            guard let folder = document.categoryFolder else { return }

            let key = slugify(folder)
            if var accumulator = result[key] {
                accumulator.count += 1
                result[key] = accumulator
            } else {
                result[key] = CategoryAccumulator(name: displayName(fromFolder: folder), sourceFolder: folder, count: 1)
            }
        }

        return counts
            .map { key, accumulator in
                BlogCategoryEntry(
                    name: accumulator.name,
                    slug: key,
                    sourceFolder: accumulator.sourceFolder,
                    count: accumulator.count
                )
            }
            .sorted {
                $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
            }
    }

    private struct TagAccumulator {
        var name: String
        var count: Int
    }

    private struct CategoryAccumulator {
        var name: String
        var sourceFolder: String
        var count: Int
    }

    private static func parseTags(from markdown: String) -> [String] {
        let normalizedMarkdown = normalizeLineEndings(markdown)

        guard let frontMatter = frontMatterBlock(in: normalizedMarkdown) else {
            return []
        }

        let lines = frontMatter
            .split(separator: "\n", omittingEmptySubsequences: false)
            .map(String.init)

        for index in lines.indices {
            let trimmedLine = lines[index].trimmingCharacters(in: .whitespacesAndNewlines)
            guard trimmedLine.lowercased().hasPrefix("tags:") else { continue }

            let rawValue = trimmedLine.dropFirst("tags:".count)
            let inlineTags = parseInlineTags(from: rawValue)
            if !inlineTags.isEmpty {
                return inlineTags
            }

            guard index + 1 < lines.count else { return [] }
            return parseListTags(from: lines[(index + 1)...])
        }

        return []
    }

    private static func frontMatterBlock(in markdown: String) -> String? {
        let lines = markdown.split(separator: "\n", omittingEmptySubsequences: false)
        guard lines.first?.trimmingCharacters(in: .whitespacesAndNewlines) == "---" else {
            return nil
        }

        guard lines.count > 1 else { return nil }

        guard let endIndex = lines[1...].firstIndex(where: { $0.trimmingCharacters(in: .whitespacesAndNewlines) == "---" }) else {
            return nil
        }

        let frontMatterLines = lines[1..<endIndex]
        return frontMatterLines.joined(separator: "\n")
    }

    private static func categoryFolder(for relativePath: String) -> String? {
        let components = relativePath
            .trimmingCharacters(in: CharacterSet(charactersIn: "/"))
            .split(separator: "/")
            .map(String.init)

        guard components.count >= 2 else {
            return nil
        }

        if components.first == "Posts" {
            return components.count >= 3 ? components[1] : nil
        }

        return components[0]
    }

    private static func displayName(fromFolder folder: String) -> String {
        folder
            .split(separator: "-")
            .map { $0.prefix(1).uppercased() + $0.dropFirst() }
            .joined(separator: " ")
    }

    private static func parseInlineTags(from rawValue: Substring) -> [String] {
        rawValue
            .split(separator: ",")
            .map { tag in
                tag.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            .filter { !$0.isEmpty }
    }

    private static func parseListTags(from lines: ArraySlice<String>) -> [String] {
        var tags: [String] = []

        for line in lines {
            let trimmedLine = line.trimmingCharacters(in: .whitespacesAndNewlines)
            if trimmedLine.isEmpty {
                if !tags.isEmpty { continue }
                continue
            }

            guard trimmedLine.hasPrefix("-") else { break }

            let tag = trimmedLine
                .dropFirst()
                .trimmingCharacters(in: .whitespacesAndNewlines)
            if !tag.isEmpty {
                tags.append(tag)
            }
        }

        return tags
    }

    private static func slugify(_ value: String) -> String {
        value
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
            .replacingOccurrences(of: " ", with: "-")
            .replacingOccurrences(of: "_", with: "-")
    }

    private static func normalizeLineEndings(_ string: String) -> String {
        string
            .replacingOccurrences(of: "\r\n", with: "\n")
            .replacingOccurrences(of: "\r", with: "\n")
    }
}
