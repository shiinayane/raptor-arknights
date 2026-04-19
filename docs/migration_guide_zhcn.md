# Raptor Migration Checklist (Hexo → Swift)

> 目标：不是“复制 Hexo 主题”，而是用 Swift（Raptor）重建其信息架构与视觉语言。

---

## 🧭 总体策略

- ❌ 不做：模板翻译（Pug → Swift 逐行对应）
- ❌ 不做：CSS 全量复制
- ❌ 不做：复刻 Hexo 插件体系

- ✅ 要做：信息架构迁移
- ✅ 要做：组件边界重建
- ✅ 要做：设计 token 提炼
- ✅ 要做：视觉系统重写（Stage 2）

---

## 🧱 Raptor 分层模型（关键理解）

在开始 Stage 2 之前，需要先建立一个新的心智模型：

Raptor 已经帮你把“博客系统”拆成了多个清晰的层，而不是像 Hexo 那样集中在模板 + CSS。

建议按下面方式理解：

- **Theme（主题层）**
  - 全局设计 token（字体 / 字号 / 行高 / 颜色 / 宽度 / code theme）
  - light / dark 模式差异

- **Style（样式组件层）**
  - 可复用视觉组件（card / meta / tag pill / panel 等）
  - 会被编译成 CSS class

- **PostProcessor（内容处理层）**
  - Markdown → HTML 的预处理
  - excerpt / 标题处理 / 代码增强 / 自定义语法

- **PostWidget（文章组件层）**
  - 在 Markdown 中插入复杂组件
  - 如 callout / repo card / demo block

- **Layout / Page（页面结构层）**
  - 页面骨架与组合
  - header / footer / 页面布局

- **少量 CSS / JS（补丁层）**
  - 仅用于框架表达不了的复杂情况

👉 Stage 2 的核心不是“写样式”，而是：

> **把职责放到正确的层里。**

---

## 1️⃣ Layout（全局结构）

### 在 Hexo 中看：

- `layout/layout.pug`
- `layout/includes/header.pug`
- `layout/includes/footer.pug`
- `layout/includes/aside.pug`

### 你要提取的：

- 页面区域划分（header / main / footer / sidebar）
- 导航结构（menu、logo、入口）

### 在 Raptor 中实现：

- `MainLayout.swift`
- `SiteHeader.swift`

### 检查项：

- [ ] 是否所有页面共享同一个 Layout
- [ ] header / footer 是否统一管理
- [ ] content 是否只负责页面内容

---

## 2️⃣ 页面（Page Templates）

### 在 Hexo 中看：

- `layout/index.pug`（首页）
- `layout/post.pug`（文章页）
- `layout/archive.pug`
- `layout/tag.pug`
- `layout/category.pug`

### 你要提取的：

- 页面展示的数据结构（post list / 单篇文章 / 分组方式）
- 用户浏览路径（从首页 → 文章 → 分类/标签）

### 在 Raptor 中实现：

- `Home.swift`
- `ArticlePage.swift`
- `ArchivePage.swift`
- `TagDetailPage.swift`
- `CategoryDetailPage.swift`

### 检查项：

- [ ] 每个页面只负责一种数据视图
- [ ] 页面之间复用组件，而不是复制代码
- [ ] 数据来源统一使用 `@Environment(\.posts)`

---

## 3️⃣ 组件（Components）

### 在 Hexo 中看：

- `layout/includes/*.pug`

### 你要提取的：

- post card
- post meta
- navigation
- tag list / category list

### 在 Raptor 中实现：

- `PostListItem.swift`
- `PostMeta.swift`
- `SiteHeader.swift`

### 检查项：

- [ ] 是否有可复用组件，而不是在页面中重复写 UI
- [ ] 组件是否只关心 UI，不处理复杂逻辑
- [ ] 页面是否通过组合组件构建

---

## 4️⃣ 数据层（你自己实现的部分）

### 在 Hexo 中：

- tag/category/archive 是内建的

### 在 Raptor 中你实现了：

- `BlogContentDiscovery`
- `BlogTagEntry`
- `BlogCategoryEntry`
- `ArchiveSection`

### 检查项：

- [ ] Markdown → 数据（tags/category）解析是否稳定
- [ ] slug 是否统一（URL 安全）
- [ ] category 来源是否一致（当前为 folder）

---

## 5️⃣ 样式（Stage 2：基于 Raptor 分层重建）

### 核心思路

不要把样式当作“CSS 文件集合”，而要按 Raptor 的层来拆：

### ① Theme（先做）

负责全局视觉系统：

- 字体（body / title / code）
- 字号（title1 ~ title6）
- 字重 / 行高
- accent / foreground / background
- 内容宽度（contentWidth）
- code block / inline code 主题
- light / dark 模式差异

👉 目标：建立“站点基调”

---

### ② Style（第二步）

负责可复用视觉组件：

- PostCard（文章卡片）
- MetaRow（时间 / 阅读时间 / 分类 / 标签）
- Tag / Category pill
- Archive group block

👉 目标：让首页 / archive / tag / category 页面视觉统一

---

### ③ Layout / Page（第三步）

在 Theme + Style 基础上做：

- 页面骨架（MainLayout）
- Header（SiteHeader）
- 页面组合（Home / Archive / Tag / Category）

👉 目标：形成完整页面结构，而不是零散样式

---

### ④ Article（阅读体验）

重点优化：

- 标题区（title / meta / spacing）
- 正文排版（行高 / 段落 / heading）
- code block 风格
- prev / next 区块

👉 这是博客最重要的页面

---

### ⑤ 后续（不是 Stage 2 必做）

#### PostProcessor

- excerpt 规则
- Markdown 增强（callout / definition list / footnotes 等）

#### PostWidget

- 文章内组件（note / warning / repo card / demo block）

👉 用于提升“内容表达能力”，而不是视觉本身

---

### 不要做：

- ❌ 整个 CSS 目录复制
- ❌ 依赖原 class 名结构
- ❌ 在每个页面写样式 patch

---

### 检查项：

- [ ] 是否先完成 Theme，再写组件样式
- [ ] 是否用 Style 统一组件视觉
- [ ] 是否避免在 Page 中写大量样式
- [ ] 是否没有依赖 Hexo DOM 结构

---

## 6️⃣ 配置（Hexo `_config.yml`）

### 在 Hexo 中：

- 菜单
- 主题开关
- 各种 feature flag

### 在 Raptor 中：

- 用 Swift 常量 / struct 替代

### 检查项：

- [ ] 是否避免引入 YAML 配置系统
- [ ] 是否用代码明确表达结构

---

## ⚠️ 常见错误

- ❌ 按文件迁移（layout.pug → layout.swift）
- ❌ 按 CSS 文件迁移
- ❌ 试图“复刻 Hexo”

---

## ✅ 正确心智模型

> Hexo = 模板驱动网站
> Raptor = 代码驱动网站

---

## 🎯 最终目标

- Stage 1：功能完整（你已完成）
- Stage 2：视觉系统 + 架构分层（进行中）
- Stage 3：内容系统增强（PostProcessor / Widget）

👉 最终你得到的不是“一个主题”，而是：

> **一个基于 Raptor 的博客框架（Theme + Style + 内容系统）**
