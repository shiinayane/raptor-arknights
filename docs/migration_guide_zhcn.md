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

## 5️⃣ 样式（Stage 2 才开始）

### 在 Hexo 中看：

- `source/css/`
- `_variables.styl`

### 不要做：

- ❌ 整个 CSS 目录复制
- ❌ 依赖原 class 名结构

### 要做：

#### 先提炼 token：

- 颜色（背景 / panel / accent）
- 字体（title / body）
- 间距（spacing）
- 圆角 / 阴影
- 内容宽度

#### 再按组件实现：

- Layout（全局骨架）
- Typography（文字系统）
- PostListItem（卡片）
- ArticlePage（阅读体验）

### 检查项：

- [ ] 是否先做 token 再写样式
- [ ] 是否按组件写样式而不是按页面
- [ ] 是否避免依赖 Hexo DOM 结构

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
- Stage 2：视觉系统（正在开始）

> 你现在做的是：**rebuild，而不是 port**
