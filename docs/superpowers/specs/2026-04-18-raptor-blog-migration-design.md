# Raptor Blog Migration Design

**Date:** 2026-04-18

**Goal:** Use Raptor to build a blog that first delivers complete core blog functionality, then incrementally recreates the visual language of `Examples/hexo-theme-arknights`, while keeping the implementation Swift-native and avoiding unnecessary Hexo-era features.

## Context

This repository is currently a lightly modified Raptor starter. The local `Sources/Site.swift` already defines a basic `Arknights: Site` entry, and the repository includes two key references:

- `Examples/raptor-build`: official Raptor documentation site and the best reference for how a real Raptor site composes `Site`, `Layout`, `Page`, `PostPage`, theme, and reusable components.
- `Examples/hexo-theme-arknights`: the visual and information-architecture reference to be migrated, but only selectively. Its Hexo-specific plugin surface should not define the architecture of the new site.

The migration should follow the user's priorities:

- Be as Swift-native as possible.
- Build in two stages: blog functionality first, visual style second.
- Exclude comments, statistics, and similar enhancements for now.

## Non-Goals

These are explicitly out of scope for the first migration stage:

- Comment systems: Giscus, Utterances, Waline, Valine, Gitalk, Artalk
- Site/page view statistics and visitor counters
- PJAX
- Search
- Background music
- Hexo custom tags and filter plugins
- Content encryption
- Monaco editor embedding
- Mermaid and MathJax enhancements

They may be revisited later, but they should not shape the first-pass architecture.

## Recommended Migration Strategy

Use a **Raptor-native rebuild** strategy, not a template translation strategy.

### Why this strategy

- Raptor already gives the correct architectural primitives: `Site`, `Layout`, `Page`, `PostPage`, themes, post collections, and reusable HTML components.
- Directly translating Pug templates and Hexo config conventions into Swift would preserve legacy constraints without preserving the benefits of Hexo itself.
- The target theme is valuable mainly as a reference for:
  - page inventory
  - information hierarchy
  - visual language
  - motion and interaction style

### Working rule

For each feature, first ask:

1. What is the user-facing behavior in `hexo-theme-arknights`?
2. What is the most idiomatic Raptor/Swift representation of that behavior?

The migration should preserve behavior and visual intent where useful, but not the original implementation model.

## Stage Plan

### Stage 1: Core Blog Functionality

Deliver a complete, minimal, maintainable blog with these pages:

- Home page with post list
- Post detail page
- Archive page
- Tag index and tag detail pages
- Category index and category detail pages
- Basic global navigation

This stage is complete when the blog has coherent navigation, taxonomy browsing, and article reading flow, even if the visuals are still close to a clean Raptor default rather than the arknights theme.

### Stage 2: Visual Recreation

Once Stage 1 is stable, restyle the site to move toward the arknights look:

- dark/light token system
- typography choices
- header silhouette and chrome
- side structure and panel treatment
- page-specific spacing and framing
- article visual treatment
- background layers and atmospheric details

Stage 2 should reuse the Stage 1 page/component boundaries rather than reshaping the app around CSS-first concerns.

## Target Architecture

The first implementation pass should be organized around small Swift units with single responsibilities.

### Site Layer

- `Sources/Site.swift`
  - Site metadata
  - layout registration
  - page registration
  - theme registration
  - future feed/search hooks if needed later

This file should stay declarative and short.

### Layout Layer

- `Sources/Layouts/BlogLayout.swift`
  - global document shell
  - site header
  - optional shared sidebar slot or side rail slot
  - footer
  - shared metadata placement

This should replace the structural role of `layout/includes/layout.pug` and `layout/includes/header.pug`, but in a cleaner Swift form.

### Page Layer

- `Sources/Pages/Home.swift`
  - render recent/all posts
  - establish the top-level browsing experience

- `Sources/Pages/Archive.swift`
  - group posts by year and month
  - render archive navigation and archive list

- `Sources/Pages/Tags.swift`
  - tag index
  - tag detail pages

- `Sources/Pages/Categories.swift`
  - category index
  - category detail pages

These pages should mirror the functional page inventory of the Hexo theme without copying its template structure literally.

### Post Layer

- `Sources/PostPages/ArticlePage.swift`
  - title
  - description/subtitle if present
  - publish/update metadata
  - rendered article body
  - previous/next navigation
  - optional table-of-contents slot later

This is the Raptor equivalent of the core responsibilities in `layout/post.pug`, minus comments and counters.

### Component Layer

- `Sources/Components/NavigationBar.swift`
- `Sources/Components/PostCard.swift`
- `Sources/Components/PostMeta.swift`
- `Sources/Components/TaxonomyList.swift`
- `Sources/Components/ArchiveGroup.swift`

The exact file names may vary, but the principle should not: shared view fragments belong in focused components, not in large page files.

### Theme Layer

- `Sources/Themes/BlogTheme.swift`
  - typography defaults
  - content width
  - color tokens
  - code style
  - basic spacing rhythm

In Stage 1, this should stay restrained. It exists to make the blog readable and structurally sound, not to finish the arknights look early.

### Data Helpers

- `Sources/Types/ArchiveGroup.swift`
- `Sources/Types/TaxonomyGroup.swift`
- `Sources/Types/NavItem.swift`
- `Sources/Support/BlogIndex.swift` or similar helper module

These helpers will likely be needed because Hexo provides archive/tag/category grouping implicitly, while Raptor encourages building this logic deliberately in Swift.

## Page Mapping From Hexo Theme

The migration should treat the Hexo theme as a source of page behavior, not as a line-by-line source conversion.

### Home

Reference:

- `Examples/hexo-theme-arknights/layout/index.pug`
- `Examples/hexo-theme-arknights/layout/includes/recent-posts.pug`

Migration intent:

- Keep the idea of a post-focused landing page.
- Do not recreate paginator behavior immediately unless Stage 1 truly needs it.
- Start with a simple post list or grouped card list.

### Post Detail

Reference:

- `Examples/hexo-theme-arknights/layout/post.pug`

Migration intent:

- Keep title, key metadata, content body, and previous/next navigation.
- Skip comments, counters, reward panels, and encryption branches.
- Treat TOC as optional for Stage 1; include only if Raptor makes it cheap and clean.

### Archive

Reference:

- `Examples/hexo-theme-arknights/layout/archive.pug`
- `Examples/hexo-theme-arknights/layout/includes/archive-aside.pug`

Migration intent:

- Preserve the archive browsing experience.
- Use Swift-side grouping by year-month rather than template-time iteration hacks.
- Keep the archive readable even before visual styling is ported.

### Tags and Categories

Reference:

- `Examples/hexo-theme-arknights/layout/tag.pug`
- `Examples/hexo-theme-arknights/layout/category.pug`

Migration intent:

- Preserve taxonomy browsing as first-class navigation.
- Build explicit taxonomy models and route generation in Swift.

### Shared Shell

Reference:

- `Examples/hexo-theme-arknights/layout/includes/header.pug`
- `Examples/hexo-theme-arknights/layout/includes/aside.pug`
- `Examples/hexo-theme-arknights/_config.yml`

Migration intent:

- Carry over the information architecture:
  - site name
  - menu
  - logo/avatar area
  - taxonomy entry points
- Do not carry over the Hexo config surface wholesale.
- Replace YAML-driven theme switches with Swift data structures and focused configuration points.

## Stage 1 Functional Requirements

### 1. Content model

Posts should continue to be authored as Raptor posts/markdown content. The implementation should support:

- title
- description or subtitle if available
- publish date
- updated date if available
- tags
- categories
- canonical path

If the current starter content model does not yet expose tags/categories in the desired way, that gap should be solved at the content integration layer rather than papered over in page rendering.

### 2. Home page

The home page must:

- list posts in reverse chronological order
- expose title and short metadata
- provide clear entry into article detail pages
- provide obvious navigation to archive, tags, and categories

### 3. Article page

The article page must:

- render the post body cleanly
- show primary metadata
- support previous/next article navigation
- remain readable without any JavaScript dependency

### 4. Archive page

The archive page must:

- group posts by date bucket
- support direct entry into old posts
- be easy to scan when the post count grows

### 5. Tag and category pages

The taxonomy pages must:

- show all available tags/categories
- show counts where useful
- link into per-tag/per-category article lists
- use the same article list component patterns where possible

### 6. Navigation shell

The site shell must:

- expose top-level destinations consistently
- support future style expansion without restructuring the whole layout
- avoid embedding page-specific logic in the layout

## Stage 2 Visual Requirements

Stage 2 should recreate the **character** of the arknights theme, not blindly replay every asset and flourish.

### Keep

- strong panel framing
- high-contrast accent colors
- industrial / tactical visual tone
- deliberate typography
- clear separation of navigation chrome vs reading surface
- dark-first sensibility with usable light mode

### Adapt

- sidebars and header arrangement should fit Raptor page composition cleanly
- CSS token names should be Swift/Raptor-friendly rather than copied from Stylus variables
- effects such as animated backgrounds or cursors should be added only if they still feel intentional after the core site works

### Defer until the end of Stage 2

- ornamental motion
- atmospheric background effects
- novelty interactions that complicate accessibility or maintainability

## Migration Route

The migration should proceed in this order.

### Step 1: Establish the blog shell

Create a stable `BlogLayout` and top-level navigation model.

Outcome:

- every future page shares one shell
- visual restyling later has a single place to anchor from

### Step 2: Make posts first-class

Implement the article page and home page post list.

Outcome:

- the site becomes a usable blog immediately
- all later taxonomy pages reuse post presentation primitives

### Step 3: Add archive browsing

Implement date grouping and archive rendering.

Outcome:

- the blog now supports historical browsing without relying on search

### Step 4: Add tags and categories

Build taxonomy aggregation and pages.

Outcome:

- navigation reaches parity with the requested Stage 1 feature set

### Step 5: Harden component boundaries

Extract repeated fragments into small components and helper types.

Outcome:

- Stage 2 visual work can move quickly without large structural rewrites

### Step 6: Begin visual recreation

Port theme tokens, fonts, panel language, and layout atmosphere.

Outcome:

- the site starts resembling `hexo-theme-arknights` without sacrificing the cleaner Swift architecture

## Key Tradeoffs

### Deliberate reimplementation vs feature parity

The project should prefer deliberate reimplementation in Swift over chasing immediate feature parity with the Hexo theme. This is the only way to stay aligned with the "as swifty as possible" requirement.

### Lean Stage 1 vs overbuilding infrastructure

Stage 1 should stop at the first coherent blog. It should not accumulate abstractions for hypothetical later enhancements like comments, counters, search, or client-side transitions.

### Visual fidelity vs maintainability

Visual fidelity is important, but only after the page and component boundaries are correct. Recreating the theme too early would make the resulting code harder to evolve.

## Testing and Verification Strategy

The implementation phase should verify:

- site builds successfully with `raptor build`
- preview runs correctly with `raptor run --preview`
- all core routes render:
  - `/`
  - post detail routes
  - archive route
  - tags route(s)
  - categories route(s)
- taxonomy counts and archive grouping are correct for sample content
- navigation links remain valid after content additions

Visual verification for Stage 1 should focus on readability and route correctness, not theme parity.

## Recommended First Implementation Plan Scope

The first implementation plan should cover only Stage 1. Stage 2 should be written as a separate plan after the Stage 1 result is running and reviewed in the browser.

That Stage 1 implementation plan should produce:

- one global layout
- one home page
- one article page
- archive support
- tags support
- categories support
- a minimal theme file
- focused reusable components

This is the smallest scope that satisfies the requested "blog first" milestone without drifting into enhancement work.
