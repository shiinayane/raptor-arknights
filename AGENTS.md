# AGENTS

## Project Overview

- This repository is a Swift/Raptor blog project.
- The end goal is to rebuild a personal blog in Raptor, using `Examples/raptor-build` as the primary framework reference and `Examples/hexo-theme-arknights` as the visual and information-architecture reference.
- Delivery happens in two stages:
  1. core blog functionality
  2. visual recreation of the arknights theme

## Current Status

- The repository is still close to the Raptor starter template.
- Existing app entry is in `Sources/Site.swift`.
- Existing layout is in `Sources/Layouts/MainLayout.swift`.
- Existing home page is in `Sources/Pages/Home.swift`.
- A migration design spec already exists at `docs/superpowers/specs/2026-04-18-raptor-blog-migration-design.md`.

## Source Of Truth

- Framework usage and idiomatic Raptor composition: `Examples/raptor-build`
- Target visual style and page inventory: `Examples/hexo-theme-arknights`
- Migration scope and sequencing: `docs/superpowers/specs/2026-04-18-raptor-blog-migration-design.md`

When these references conflict, prefer:

1. user instructions
2. migration spec
3. idiomatic Raptor design
4. direct Hexo parity

## Build Priorities

Build in this order:

1. home page post list
2. post detail page
3. archive page
4. tag pages
5. category pages
6. shared navigation/layout
7. visual styling pass

Do not jump to decorative theme work before the blog is functionally complete.

## Explicit Non-Goals For Now

Do not spend time on these unless the user explicitly asks:

- comments
- analytics / PV / UV counters
- PJAX
- search
- background music
- Hexo custom tag plugins
- article encryption
- Monaco editor embedding
- Mermaid / MathJax enhancements

## Working Style

- Keep the implementation Swift-native. Do not port Pug, Stylus, or Hexo config patterns mechanically.
- Prefer small focused Swift files over large template-like files.
- Reusable UI belongs in components, not duplicated across pages.
- If a Hexo feature requires special logic, implement the behavior in idiomatic Swift rather than emulating Hexo internals.
- Favor simple, readable primitives first. Add abstraction only when two or more pages need it.

## Directory Guidance

- `Sources/Site.swift`: site registration and global metadata only; keep it declarative.
- `Sources/Layouts/`: shared document shells and top-level layout primitives.
- `Sources/Pages/`: standalone pages such as home, archive, tags, categories.
- `Sources/PostPages/`: post-detail rendering once introduced.
- `Sources/Components/`: reusable UI fragments.
- `Sources/Types/` or `Sources/Support/`: archive grouping, taxonomy grouping, navigation models, and other helper types.
- `Posts/`: markdown post content.
- `Assets/`: project-owned fonts, images, and static assets.

## Editing Rules

- Expect the worktree to be dirty. Do not revert unrelated user changes.
- At the time this file was created, `Package.swift` and `Sources/Site.swift` already had uncommitted modifications. Read them carefully before editing.
- Preserve ASCII unless a file already requires Unicode.
- Keep comments sparse and only where structure is otherwise unclear.

## Verification

Use these commands for local verification when relevant:

```bash
raptor build
raptor run --preview
```

If `raptor` is unavailable, fall back to the Swift package entrypoint already configured in the repository.

Before claiming a feature is complete, verify at minimum:

- the site builds
- the affected routes render
- navigation links resolve
- archive/tag/category grouping behaves as expected for current content

## Implementation Notes For Future Agents

- Stage 1 should produce a usable blog even if it still looks visually plain.
- Stage 2 should layer the arknights visual language onto stable page and component boundaries instead of restructuring everything again.
- Use `Examples/raptor-build/Sources/Site.swift`, `MainLayout.swift`, `Home.swift`, and `MainArticle.swift` as the clearest reference for how to compose Raptor pages and post pages.
