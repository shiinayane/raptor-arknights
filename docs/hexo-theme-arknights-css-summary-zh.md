# hexo-theme-arknights CSS 职责梳理

本文用于迁移 `Examples/hexo-theme-arknights/source/css` 到 Raptor 时做结构拆分。这里不逐条解释样式细节，而是按目录和文件说明“它负责什么”“迁移时应该落到哪里”。

## 总入口

### `arknights.styl`

- 主题总入口。
- 导入顺序很明确：`_core` 基础能力，`_modules` 可选模块，`_page` 页面样式，`_custom` 用户覆写。
- 迁移时可以保留这四层责任边界，但不要机械照搬 Stylus 结构；在 Raptor 里更适合映射为全局基础样式、组件样式、页面样式、项目覆盖层。

## `_core` 基础层

### 目录职责

- `_core` 负责全站通用能力，不绑定某一页。
- 包含设计令牌、基础元素、布局骨架、头部导航、侧栏、滚动条、光标、脚注等。
- `core.styl` 是 `_core` 的聚合入口，并根据 `aside.in_left` 决定左右布局变体。

### 文件职责

#### `core.styl`

- 聚合所有基础样式。
- 导入顺序是：基础元素、特效、侧栏、配色、头部、整体布局。
- 根据配置切换 `aside` / `header` 的左右版本。

#### `base.styl`

- 全站 HTML 元素基线样式。
- 定义 `body` 背景、默认字体、链接、标题、段落、按钮、代码块、表格、引用、任务列表等。
- 迁移时应成为 Raptor 的全局 reset/base typography 层。

#### `cursor.styl`

- 自定义鼠标外圈和点击扩散效果容器样式。
- 依赖 JS 驱动位置变化。
- 如果 Stage 1 不做装饰效果，可以延后迁移。

#### `footnotes.styl`

- 脚注悬浮气泡样式。
- 为脚注引用提供 tooltip 弹层体验。
- 属于文章内容增强，可放在 post-content 相关样式中。

#### `scrollbar.styl`

- 桌面端主滚动区域和 WebKit 滚动条视觉统一。
- 纯表现层，不影响结构。

### `_core/color`

#### `color/base.styl`

- 定义与主题无关的基础设计变量，主要是光标图与 admonition 色值。

#### `color/dark.styl`

- 暗色模式变量表。
- 定义背景、文本、高亮、边框、标签、加载条等颜色语义。

#### `color/light.styl`

- 亮色模式变量表。
- 与 `dark.styl` 对应，是同一套语义 token 的 light 实现。

#### `color/change.styl`

- 处理深浅色切换时的过渡和差异化行为。
- 包括标题/卡片过渡、亮色模式下的 hover 修正、颜色模式按钮旋转动效等。

#### `color/atom-one.styl`

- 代码高亮主题。
- 按 `theme-mode` 分别给 `hljs` 提供 dark/light 配色。

### `_core/aside`

#### `aside/aside.styl`

- 定义全站侧栏主体。
- 包括 logo、作者区、描述、导航块、统计块、TOC 容器、footer 的样式。
- 是侧栏组件的主样式文件。

#### `aside/toc.styl`

- 专门控制目录树 `#toc-div` 的层级列表样式、展开态和当前项高亮。
- 直接服务文章详情页侧栏目录。

#### `aside/icp.styl`

- 备案号和版权徽标的条状样式。
- 纯 footer 信息块样式。

#### `aside/layout/left.styl`

- 侧栏位于左侧时的布局偏移、间距和超宽屏补偿。

#### `aside/layout/right.styl`

- 侧栏位于右侧时的布局偏移、间距和超宽屏补偿。

### `_core/header`

#### `header/header.styl`

- 头部导航通用样式。
- 包括 `header`、`nav`、一级菜单项、激活态边框等。

#### `header/navBtn.styl`

- 移动端汉堡按钮与展开动画。

#### `header/navSecond.styl`

- 二级菜单/下拉菜单样式。
- 负责移动端展开与桌面端悬浮子菜单。

#### `header/flex_layout.styl`

- 头部导航在不同断点下的宽度、定位和排版规则。
- 控制移动端抽屉式导航与桌面端纵向导航的切换。

#### `header/layout/left.styl`

- 当侧栏在左侧时，头部导航切到右边后的镜像布局规则。
- 处理箭头方向、子菜单展开方向、hover 位移方向。

#### `header/layout/right.styl`

- 默认右侧侧栏场景下的头部布局规则。
- 与 `left.styl` 互为镜像。

### `_core/layout`

#### `layout/flex_layout.styl`

- 页面主骨架布局。
- 控制 `main / article / aside` 在移动端和桌面端的尺寸关系，也包含 archive 页、TOC 抽屉、分页、logo 浮层等整体行为。
- 这是最接近“站点壳层”的样式文件。

#### `layout/single_page.styl`

- 移动端单页切换状态样式。
- 主要处理 `up / moving / closed` 等类名下的过渡，避免导航展开或收起时页面抖动。
- 依赖 PJAX/搜索/导航相关 JS 状态类。

## `_modules` 模块层

### 目录职责

- `_modules` 负责可选或半可选能力，不是所有页面都必须依赖。
- `modules.styl` 根据主题配置决定是否导入搜索、PJAX、粒子背景等模块，再统一引入卡片、评论、社交、折叠块、图片灯箱。

### 文件职责

#### `modules.styl`

- 模块聚合入口。
- 条件导入 `canvas_dust`、搜索、PJAX。
- 无条件导入 cards、expand、social、comments、lightgallery。

#### `canvas_dust.styl`

- 全屏粒子画布层。
- 仅负责固定定位和层级，不负责粒子算法。
- 属于明确的非核心装饰，可后置。

#### `expand.styl`

- 通用折叠容器样式。
- 负责 `.expand-box`、标题栏、展开/收起箭头、内容区高度动画。
- 代码块折叠和一些扩展卡片都复用这个结构。

#### `social.styl`

- 作者社交链接区域样式。
- 负责侧栏图标排列和图片型图标尺寸。

#### `lightgallery.styl`

- 图片灯箱容器层级和鼠标样式修正。
- 依赖外部 LightGallery 脚本。

#### `pjax.styl`

- PJAX 页面切换时的加载条、内容淡入淡出、分页/底部按钮隐藏逻辑。
- 纯前端增强，Stage 1 可不迁。

### `_modules/search`

#### `search/base.styl`

- 搜索模块主样式。
- 定义搜索输入框、占位区域、结果弹层、结果列表、加载态，以及桌面端背景模糊。

#### `search/left.styl`

- 侧栏在左侧时，搜索抽屉的定位与动画规则。

#### `search/right.styl`

- 侧栏在右侧时，搜索抽屉的定位与动画规则。

#### `search/single_page.styl`

- 移动端单页状态下的搜索专用过渡。
- 解决导航收起、搜索框顶置、搜索面板进出场的问题。

### `_modules/cards`

#### `cards/admonition.styl`

- 提示框/告警框样式。
- 提供 `note / warning / success / failure / detail` 的配色和图标。

#### `cards/hide.styl`

- “隐藏文本”卡片样式。
- 默认通过前景/背景同色隐藏内容，hover 后显现。

#### `cards/link-card.styl`

- 外链卡片样式。
- 定义缩略图、站点图标、标题、描述和 hover 边框变化。

### `_modules/comments`

#### `comments/comments.styl`

- 评论系统总入口。
- 按启用情况引入具体评论提供方样式，并在存在多个评论源时启用切换器。

#### `comments/selector.styl`

- 多评论源切换按钮条样式。

#### `comments/valine.styl`

- Valine 皮肤覆写。

#### `comments/gitalk.styl`

- Gitalk 大量 UI 覆写。
- 包含登录、输入框、按钮、弹层、元信息、加载器等。

#### `comments/waline.styl`

- Waline 变量和按钮风格覆写。

#### `comments/utterances.styl`

- Utterances 容器尺寸和光标样式修正。

#### `comments/giscus.styl`

- Giscus 容器、加载态、错误态、自定义重试按钮样式。

## `_page` 页面层

### 目录职责

- `_page` 负责页面级结构样式，是从通用壳层向具体页面落地的一层。
- `page.styl` 聚合 archive、article、taxonomy、post 各页样式。

### 文件职责

#### `page.styl`

- 页面样式入口。
- 统一导入 archive、列表页、分类页、标签页、文章页及文章子模块。

#### `article.styl`

- 首页/列表页文章卡片与分页样式。
- 核心对象是 `.recent-post`。
- 负责分类/标签/摘要/置顶标识/read more/paginator 的外观。

#### `archive.styl`

- Archive、分类归档、标签归档三类页面的共用布局。
- 负责 `#archive-flex`、左侧 taxonomy 面板、右侧归档列表、年月标题、文章条目等。

#### `category.styl`

- 分类列表样式。
- 既服务 archive 侧栏中的分类树，也服务分类导航块。

#### `tag.styl`

- 标签云/标签列表样式。
- 负责 tag pill、计数块和 hover 状态。

### `_page/post`

#### `post/post.styl`

- 文章详情页主体样式。
- 包括文章容器、标题区、元信息、正文标题、锚点、打赏区、前后文导航。
- 是 post 页最核心的样式文件。

#### `post/code.styl`

- 代码块增强样式。
- 包括行号 gutter、可折叠容器、复制按钮、代码区 hover 行为。

#### `post/bottom_btn.styl`

- 详情页右下角浮动按钮。
- 包括回到顶部、目录开关、颜色模式开关，以及可能的 BGM 控制。

#### `post/MathJax.styl`

- 数学公式渲染区域的滚动和层级修正。

## `_custom` 覆写层

### `custom.styl`

- 预留给最终项目自定义覆盖。
- 当前文件为空，说明主题作者把“最后一层覆写”明确留给使用者。
- 迁移到 Raptor 时建议保留类似扩展点，但不要依赖它承载核心功能样式。

## 迁移映射建议

### 适合先迁的部分

- `_core/base.styl`
- `_core/color/*`
- `_core/layout/*`
- `_core/aside/aside.styl`
- `_core/header/*`
- `_page/article.styl`
- `_page/archive.styl`
- `_page/category.styl`
- `_page/tag.styl`
- `_page/post/post.styl`

这些文件基本覆盖了 Stage 1 所需的首页、详情页、归档页、标签页、分类页和共享导航/侧栏。

### 可以延后的部分

- `cursor.styl`
- `canvas_dust.styl`
- `pjax.styl`
- `search/*`
- `lightgallery.styl`
- `comments/*`
- `post/bottom_btn.styl`
- `post/MathJax.styl`
- `cards/hide.styl`
- `cards/admonition.styl`

这些都更偏增强能力或主题装饰，不应阻塞博客基础功能迁移。

### 适合在 Raptor 中的结构落点

- 全局设计变量：对应 `_core/color/*`
- 基础元素样式：对应 `_core/base.styl`
- 站点壳层 Layout：对应 `_core/layout/*`、`_core/header/*`、`_core/aside/*`
- 页面组件：
  `RecentPostCard` 对应 `article.styl`
  `ArchiveSidebar` 对应 `archive.styl` + `category.styl` + `tag.styl`
  `PostArticle` 对应 `post/post.styl`
  `PostCodeBlock` 对应 `post/code.styl`
- 可选增强模块：对应 `_modules/*`

### 迁移时要避免的事情

- 不要把 `hexo-config()` 的条件导入直接复制到 Swift；应在 Raptor 中用站点配置或组件参数决定是否渲染。
- 不要把所有样式继续堆进一个巨型文件；Hexo 的目录分层本身已经在提示“壳层/模块/页面”的边界。
- 不要先迁装饰性模块再迁页面骨架，优先保证内容结构、导航路径和 taxonomy 页面可用。
