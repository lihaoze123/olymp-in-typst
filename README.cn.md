# Olymp in Typst

[![Gitea Stars](https://img.shields.io/github/stars/lihaoze123/olymp-in-typst)](https://github.com/lihaoze123/olymp-in-typst)
[![GitHub Release](https://img.shields.io/github/v/release/lihaoze123/olymp-in-typst)](https://github.com/lihaoze123/olymp-in-typst/releases/latest)
[![GitHub last commit (dev branch)](<https://img.shields.io/github/last-commit/lihaoze123/olymp-in-typst/main?label=last%20commit%20(main%20branch)>)](https://github.com/lihaoze123/olymp-in-typst/commits/main/)
[![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/lihaoze123/olymp-in-typst)

一个用于生成算法竞赛比赛题目集的 Typst 模板（类似于 ICPC/XCPC 格式，灵感来自 olymp.sty）。只需极少的工作即可创建格式精美的 PDF 比赛试题册。

![预览](./screenshots/preview.jpg)

## 功能特性

- **专业排版**: 生成包含标题页、试题列表和统一题目布局的比赛试题册
- **中文与数学支持**: 针对中文文本优化，并支持完整的数学符号
- **样例展示**: 自动将输入/输出样例渲染为专业的表格
- **自动编号**: 题目自动标记为 "Problem A", "Problem B" 等
- **多格式支持**: 支持 Typst、LaTeX 和 Markdown
- **高度可定制**: 轻松调整比赛元数据、样式和字体
- **PDF 输出**: 直接生成适合比赛分发的 PDF 文件

## 前置要求

- 已安装 [Typst](https://typst.app/)
- 中文字体 (方正书宋_GBK, 方正黑体_GBK, 方正楷体_GBK) 以获得最佳渲染效果 (对应的字体文件名为 FZShuSong-Z01, FZHei-B01, FZKai-Z03)
- CMU 字体 (cm-unicode)

## 使用方法

本模板提供两种使用 `template.typ` 文件的方法：

### 方法 1：作为完整模板应用（推荐）

使用 `#show` 规则将模板应用到你的文档中，如 `main.typ` 中所示。这是最简单的上手方式：

```typst
#import "template.typ": contest-conf
#import "problems.typ": problems  // 或者从你的题目文件中导入

#show: contest-conf.with(
  title: "XCPC 程序设计竞赛",
  subtitle: "试题册",
  author: "你的名字",
  problems: problems
)
````

这将自动处理：

  - 标题页生成
  - 试题列表
  - 统一的题目格式
  - 页面布局和样式

### 方法 2：导入实用函数

从 `template.typ` 导入特定函数并在你自己的文档中使用：

```typst
#import "template.typ": render-problem, maketitle

// 按需使用单独的函数
#maketitle(title: "比赛名称", author: "你的名字")

// 手动渲染题目
#for problem in problems {
  render-problem(problem.problem, problem.statement)
  pagebreak()
}
```

## 快速开始

1.  克隆或下载此模板
2.  编辑 `problems.json` 以添加你的比赛题目（见下文结构）
3.  构建 PDF：
    ```bash
    typst compile main.typ
    ```

## 题目结构

使用以下 JSON 格式在 `problems.json` 中定义你的比赛题目：

```json
[
  {
    "problem": {
      "display_name": "你的题目名称",
      "latex": false,
      "samples": [
        {
          "input": "样例输入",
          "output": "样例输出"
        },
        {
          "input": "另一个输入",
          "output": "另一个输出"
        }
      ]
    },
    "statement": {
      "description": "题目描述，支持数学表达式如 $x^2 + y^2 = z^2$。",
      "input": "输入格式描述。",
      "output": "输出格式描述。",
      "notes": "可选的约束条件和提示。"
    }
  }
]
```

你也可以直接在 `problems.typ` 中使用 Typst 语法定义题目——详见模板中的两种方法。

### 题目组件

  - **`problem.display-name`**: 题目名称（标题）
  - **`problem.latex`**: 设置为 `true` 以使用 mitex 将题面字段渲染为 LaTeX（默认为 `false`）
  - **`problem.markdown`**: 设置为 `true` 以将题面字段渲染为 Markdown（默认为 `false`）
  - **`problem.samples`**: 用于题目说明的输入/输出样例对数组
  - **`statement.description`**: 完整的题目描述（支持使用 `$...$` 的数学符号）
  - **`statement.input`**: 输入数据的格式说明
  - **`statement.output`**: 输出数据的格式说明
  - **`statement.notes`**: 可选的约束、提示或额外说明

**内容格式优先级**：如果 `latex` 和 `markdown` 都设置为 `true`，LaTeX 优先级更高。

### LaTeX 支持

如果你在题目对象中设置 `"latex": true`，模板将使用 [mitex](https://github.com/mitex-rs/mitex) 包来渲染 LaTeX 内容。这适用于：

  - 你有希望重用的现有 LaTeX 题目描述
  - 你需要超出 Typst 数学模式的复杂 LaTeX 功能
  - 你正从基于 LaTeX 的比赛系统迁移

启用 LaTeX 的示例：

```json
{
  "problem": {
    "display_name": "复杂的 LaTeX 题目",
    "latex": true,
    "samples": [...]
  },
  "statement": {
    "description": "给定一个函数 $f(x) = \\frac{x^2 + 1}{x - 1}$, 计算...",
    "input": "输入包含一个整数 $n$。",
    "output": "输出结果为 \\textbf{\\frac{result}{2}}。",
    "notes": "约束条件: $0 \\le n \\le 10^9$"
  }
}
```

### Markdown 支持

如果你在题目对象中设置 `"markdown": true`，模板将使用 [cmarker](https://github.com/typst/packages/tree/main/packages/preview/cmarker) 包来渲染 Markdown 内容。这适用于：

  - 你希望使用 Markdown 更简单的语法进行格式化
  - 你需要带有标题、列表和强调的结构化内容
  - 你希望保持源文件的可读性

启用 Markdown 的示例：

```json
{
  "problem": {
    "display_name": "Markdown 示例题目",
    "markdown": true,
    "samples": [...]
  },
  "statement": {
    "description": "对于给定的整数 $n$，输出其平方。\n\n### 示例\n- 当 $n = 3$ 时，输出 `1 4 9`\n- 当 $n = 5$ 时，输出 `1 4 9 16 25`\n\n### 公式\n\n$$x^2 = x \\times x$$
",
    "input": "第一行包含整数 $n$ ($1 \\le n \\le 1000$)。",
    "output": "输出 $n$ 个数字，以空格分隔。",
    "notes": "### 约束\n- $1 \\le n \\le 1000$\n- 结果在 32 位整数范围内\n\n### 提示\n使用迭代或基于公式的方法。"
  }
}
```

Markdown 渲染器也支持使用 `$...$` 进行行内数学公式和 `$$...$$` 进行块级数学公式（由 mitex 支持）。

## API 参考

### `contest-conf`

主模板函数，将完整的比赛配置应用到你的文档。

**参数:**

  - `title` (str, 可选): 比赛标题（默认："这是一场 XCPC 程序设计竞赛"）
  - `subtitle` (str, 可选): 比赛副标题（默认："试题册"）
  - `author` (str, 可选): 比赛作者/主办方（默认："初梦"）
  - `date` (str, 可选): 比赛日期（默认：当前日期）
  - `problems` (array, 必填): 题目对象数组（见题目结构）
  - `enable-titlepage` (bool, 可选): 是否生成扉页（默认：`true`）
  - `doc` (content, 必填): 文档内容（由 `#show` 规则自动提供）

**返回值:** 包含所有题目的格式化比赛文档

**用法:**

```typst
#show: contest-conf.with(title: "我的比赛", problems: problems)
```

### `render-problem`

渲染具有统一格式的单个题目。

**参数:**

  - `problem` (dictionary): 题目元数据，包含：
      - `display-name` (str): 题目名称（将被加上前缀 "Problem A/B/C..."）
      - `latex` (bool, 可选): 启用 LaTeX 渲染（默认：`false`）
      - `markdown` (bool, 可选): 启用 Markdown 渲染（默认：`false`）
      - `samples` (array): 样例数组（每个包含 `input` 和 `output`）
  - `statement` (dictionary): 题目描述，包含：
      - `description` (content): 题目详细描述
      - `input` (content, 可选): 输入格式说明
      - `output` (content, 可选): 输出格式说明
      - `notes` (content, 可选): 约束和提示

**返回值:** 渲染后的题目内容

**用法:**

```typst
#for problem in problems {
  render-problem(problem.problem, problem.statement)
  pagebreak()
}
```

**内容渲染:**

  - 当 `latex` 为 `true` 时：使用 mitex 将内容渲染为 LaTeX
  - 当 `markdown` 为 `true` 时：使用 cmarker 将内容渲染为 Markdown（含 mitex 数学支持）
  - 否则：内容作为 Typst 标记评估

### `maketitle`

为比赛创建标题页。

**参数:**

  - `title` (str, 可选): 主标题（默认：`none`）
  - `subtitle` (str, 可选): 副标题（默认：`none`）
  - `author` (str, 可选): 作者名（默认：`none`）
  - `date` (str, 可选): 日期（默认：`none`）

**返回值:** 格式化的标题页内容

**用法:**

```typst
#maketitle(title: "2024年比赛", author: "比赛组委会")
```

### `fonts`

字体配置字典（不是函数，而是常量）。

**包含:**

  - `serif` (array): 衬线字体栈 ("New Computer Modern", "FZShuSong-Z01")
  - `sans` (array): 无衬线字体栈 ("CMU Sans Serif", "FZHei-B01")
  - `kaishu` (array): 楷体字体栈 ("FZKai-Z03")

**用法:**

```typst
#text(font: fonts.sans)[无衬线文本]
```

## 许可证

GPL-3.0-or-later

## 贡献

欢迎提出建议和改进！本模板旨在成为比赛组织者的通用起点。