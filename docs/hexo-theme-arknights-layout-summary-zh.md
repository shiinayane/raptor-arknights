# hexo-theme-arknights Layout 模板职责梳理

本文梳理 `Examples/hexo-theme-arknights/layout` 下各个 `pug` 模板的职责，目标是为 Raptor 迁移建立页面树、共享布局和组件边界。

## 模板总体分层

当前 Pug 结构可以分成四层：

- 页面入口层：`index.pug`、`post.pug`、`page.pug`、`archive.pug`、`tag.pug`、`category.pug`
- 布局壳层：`includes/layout.pug`
- 页面局部组件：`includes/header.pug`、`includes/aside.pug`、`includes/recent-posts.pug`、`includes/archive-aside.pug`、`includes/bottom-btn.pug`
- 资源与运行时注入：`includes/meta-data.pug`、`includes/generate-css.pug`、`includes/js-data.pug`、`includes/pjax.pug`

迁移时不应把它们理解成“模板文件列表”，而应该理解成“站点壳层 + 页面入口 + 若干可复用组件”。

## 页面入口层

### `index.pug`

- 首页入口。
- 继承 `includes/layout.pug`。
- 在 `block content` 中渲染：
  - `.posts`
  - `includes/recent-posts.pug`
  - 分页器 `paginator()`
- 对应 Raptor 的首页文章列表页。

### `post.pug`

- 文章详情页核心模板。
- 继承 `includes/layout.pug`。
- 负责：
  - 上一篇/下一篇链接
  - 日期、更新日期、字数、阅读时长、阅读量
  - 正文内容与加密内容切换
  - 正文分页
  - 打赏区
  - 评论区与多评论源切换
  - 侧栏目录 `block aside-block`
- 对应 Raptor 的 `PostPage` 主模板。
- 它是整个主题最重要的页面模板之一。

### `page.pug`

- 普通独立页面入口。
- 直接 `extends ./post.pug`。
- 说明 Hexo 主题把“独立页”和“文章页”统一为同一套渲染壳，只是在数据来源上不同。
- 迁移时可以让 Raptor 的自定义页面复用文章详情布局。

### `archive.pug`

- 归档页入口。
- 继承 `includes/layout.pug`。
- 预先生成三份数据：
  - `categoriesList`
  - `tagsList`
  - `archivesList`
- 页面主体分成两列：
  - 左侧 `includes/archive-aside.pug`
  - 右侧 `#Archives` 年月分组文章列表
- 额外在 `aside-block` 中塞入页内导航，方便跳转到 Archives / Categories / Tags。
- 对应 Raptor 的 Archive 页面。

### `category.pug`

- 分类归档页入口。
- 结构与 `archive.pug` 基本一致，只是右侧标题改为当前分类名，文章集来自 `page.posts`。
- 对应 Raptor 的 CategoryDetail 页面。

### `tag.pug`

- 标签归档页入口。
- 结构与 `category.pug` 一致，只是标题变为当前标签。
- 对应 Raptor 的 TagDetail 页面。

## 布局壳层

### `includes/layout.pug`

- 全站最核心的文档壳层。
- 负责：
  - 根据当前页面类型计算 `<title>`
  - 准备 `asideLogo`、`pjax`、`searchConfig`、前端 `config` JSON
  - 根据主题配置计算 `html` 上的 `theme-mode`
  - 输出 `doctype/html/head/body`
  - 组合 header、article、aside
  - 在 article 内插入页面内容和底部按钮
  - 可选渲染 canvas dust 背景
  - 注入额外脚本列表
- 对应 Raptor 的 `MainLayout` / `SiteLayout`。
- 迁移时应把“站点壳层”和“页面具体内容”明确分开，这个模板就是边界参考。

## 页面局部组件

### `includes/header.pug`

- 顶部/侧向主导航组件。
- 定义了递归 `mixin expand_list(list)`，用于渲染多级菜单。
- 负责：
  - 移动端搜索输入入口
  - 主导航菜单合并：`theme.menu` + `config.menu`
  - 一级/二级菜单渲染
  - 当前导航匹配数据 `matchdata`
- 对应 Raptor 的 `HeaderNav` 组件。

### `includes/aside.pug`

- 全站侧栏组件。
- 负责：
  - logo
  - 作者名和描述
  - 社交链接
  - `block aside-block` 扩展区
  - 首页时的全站统计
  - 页脚版权和 ICP 信息
- 这个模板不是“文章侧栏”，而是整个站点长期存在的 aside shell。
- 对应 Raptor 的 `SiteAside` 组件。

### `includes/recent-posts.pug`

- 首页文章列表项循环模板。
- 每篇文章渲染：
  - 标题
  - 分类
  - 标签
  - 日期
  - 摘要
  - 置顶标识
  - Read More
- 对应 Raptor 的 `RecentPostList` / `RecentPostCard` 组件。

### `includes/archive-aside.pug`

- 归档类页面的左侧 taxonomy 面板。
- 负责渲染分类列表和标签列表。
- 被 `archive.pug`、`category.pug`、`tag.pug` 共用。
- 对应 Raptor 的 `ArchiveAside` 组件。

### `includes/bottom-btn.pug`

- 文章区域右下角浮动操作按钮。
- 可能包含：
  - 回到顶部
  - TOC 开关
  - 明暗模式切换
  - BGM 控制
- 严格说这是“文章阅读辅助组件”，不是通用页脚。
- Stage 1 可延后。

## 资源与运行时注入层

### `includes/meta-data.pug`

- head 区最重的资源注入模板。
- 负责：
  - charset / viewport / title
  - keywords、canonical、robots
  - Open Graph
  - favicon
  - 字体 preload 与 `@font-face`
  - 主样式表 `css/arknights.css`
  - `page-config` 元数据
  - giscus、waline、artalk、mermaid、MathJax、lightgallery、fontawesome 等三方资源
  - 主题模式初始化脚本
  - `generate-css.pug` 和 `js-data.pug` 的继续注入
- 对应 Raptor 中的 `<head>` 资源管理层。
- 迁移时建议拆为：
  - 基础 SEO/head
  - 主题字体与样式
  - 可选第三方脚本注入

### `includes/generate-css.pug`

- 动态生成 CSS 变量。
- 目前只负责背景图和加密提示文案。
- 这是“运行时配置转 CSS 变量”的桥。

### `includes/js-data.pug`

- 全站前端脚本装配中心。
- 负责：
  - 主脚本 `arknights.js`
  - 搜索脚本
  - vercount
  - 多评论系统初始化
  - Mermaid、MathJax、Waline、Giscus、Utterances 等运行时注入
  - LightGallery 初始化
  - PJAX 完成后的 reset 重绑定
- 这是主题交互行为的主汇聚点。
- 在 Raptor 中不宜继续堆成一个模板，最好拆成多个脚本模块或按功能分片。

### `includes/pjax.pug`

- 旧版或更小范围的 PJAX 初始化模板。
- 内容与 `js-data.pug` 中的 PJAX/reset 逻辑高度重叠。
- 从现状看，它更像历史遗留或被 `js-data.pug` 包含的兼容层。
- 迁移时应避免原样照搬，先确认是否还需要 PJAX。

## 各模板之间的依赖关系

可以粗略理解为：

1. 页面入口模板决定“当前页是什么”。
2. `includes/layout.pug` 决定“页面壳怎么包起来”。
3. 各 `includes/*.pug` 决定“壳里面有哪些复用块”。
4. `meta-data.pug` / `js-data.pug` 决定“这个页面需要哪些资源和初始化脚本”。

对应关系如下：

- `index.pug` -> `includes/layout.pug` -> `includes/recent-posts.pug`
- `post.pug` -> `includes/layout.pug` -> `includes/bottom-btn.pug` + `includes/aside.pug`
- `page.pug` -> `post.pug`
- `archive.pug` / `tag.pug` / `category.pug` -> `includes/layout.pug` -> `includes/archive-aside.pug`
- `includes/layout.pug` -> `includes/meta-data.pug` + `includes/header.pug` + `includes/aside.pug`
- `includes/meta-data.pug` -> `includes/generate-css.pug` + `includes/js-data.pug`
- `includes/js-data.pug` -> `includes/pjax.pug`

## 迁移到 Raptor 时建议拆成的对象

### 页面

- `HomePage`
- `PostPage`
- `ArchivePage`
- `TagPage`
- `CategoryPage`
- `StaticPage`

### 布局

- `MainLayout`
- `HeadMetadata`

### 组件

- `HeaderNav`
- `SiteAside`
- `RecentPostList`
- `RecentPostCard`
- `ArchiveAside`
- `PostMeta`
- `PostPagination`
- `PostComments`
- `BottomButtons`
- `TableOfContents`

### 运行时桥接

- `ThemeModeScript`
- `SearchScript`
- `CommentBootstrap`
- `GalleryBootstrap`

## 对 Stage 1 最有价值的模板

- `includes/layout.pug`
- `includes/header.pug`
- `includes/aside.pug`
- `includes/recent-posts.pug`
- `post.pug`
- `archive.pug`
- `tag.pug`
- `category.pug`
- `includes/archive-aside.pug`

这些模板已经覆盖：

- 首页文章列表
- 文章详情
- 归档页
- 标签页
- 分类页
- 共享导航/侧栏

这正好与仓库 `AGENTS.md` 里当前优先级一致。

## 迁移时要主动规避的问题

- 不要把 `meta-data.pug` 原样翻译成一个巨大的 Swift 模板；它承担了太多职责，应该拆分。
- 不要先迁 `js-data.pug` 里的评论、PJAX、Mermaid、MathJax；这些都不是 Stage 1 必需能力。
- 不要让 `post.pug` 的逻辑继续膨胀；在 Raptor 中应把文章头部、正文、翻页、评论拆开。
- 不要忽略 `page.pug extends post.pug` 这个信号；它说明“独立页和文章页共用一套壳”是正确方向。
