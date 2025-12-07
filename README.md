# Olymp in Typst

[![Gitea Stars](https://img.shields.io/github/stars/lihaoze123/olymp-in-typst)](https://github.com/lihaoze123/olymp-in-typst)
[![GitHub Release](https://img.shields.io/github/v/release/lihaoze123/olymp-in-typst)](https://github.com/lihaoze123/olymp-in-typst/releases/latest)
[![GitHub last commit (dev branch)](<https://img.shields.io/github/last-commit/lihaoze123/olymp-in-typst/main?label=last%20commit%20(main%20branch)>)](https://github.com/lihaoze123/olymp-in-typst/commits/main/)
[![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/lihaoze123/olymp-in-typst)

[中文](./README.cn.md)

A Typst template for generating competitive programming contest problem sets (similar to ICPC/XCPC format, inspired by olymp.sty). Create beautifully formatted PDF contest booklets with minimal effort.

![Perview](./screenshots/preview.jpg)

## Features

- **Professional Formatting**: Generate contest booklets with title pages, table of contents, and consistent problem layouts
- **Multilingual Support**: Built-in support for Chinese and English with easy language switching
- **Chinese & Math Support**: Optimized for Chinese text with full mathematical notation support
- **Sample Cases**: Automatic rendering of input/output samples in professional tables
- **Auto-numbering**: Problems automatically labeled as "Problem A", "Problem B", etc.
- **Multiple Content Formats**: Support for standard Typst markup, LaTeX rendering, and Markdown
- **Customizable**: Easy to adapt contest metadata, styling, and fonts
- **PDF Output**: Direct PDF generation suitable for contest distribution

## Prerequisites

- [Typst](https://typst.app/) installed
- Chinese fonts (FZShuSong-Z01, FZHei-B01, FZKai-Z03) for optimal rendering
- CMU fonts (cm-unicode)

## Usage

This template provides two ways to use the `template.typ` file:

### Method 1: Apply as a Complete Template (Recommended)

Apply the template to your document using `#show` rule, as demonstrated in `main.typ`. This is the easiest way to get started:

```typst
#import "template.typ": contest-conf
#import "problems.typ": problems  // or import from your problems file

#show: contest-conf.with(
  title: "XCPC Programming Contest",
  subtitle: "Problem Set",
  author: "Your Name",
  language: "en",  // "zh" for Chinese (default), "en" for English
  problems: problems
)
```

This automatically handles:
- Title page generation
- Table of contents
- Consistent problem formatting
- Page layout and styling

### Method 2: Import Utility Functions

Import specific functions from `template.typ` and use them in your own document:

```typst
#import "template.typ": render-problem, maketitle

// Use individual functions as needed
#maketitle(title: "Contest Name", author: "Your Name")

// Render problems manually
#for problem in problems {
  render-problem(problem.problem, problem.statement)
  pagebreak()
}
```

## Quick Start

1. Clone or download this template
2. Edit `problems.json` to add your contest problems (see structure below)
3. Build the PDF:
   ```bash
   typst compile main.typ
   ```

## Problem Structure

Define your contest problems in `problems.json` using the following JSON format:

```json
[
  {
    "problem": {
      "display_name": "Your Problem Name",
      "format": "latex",
      "samples": [
        {
          "input": "sample input",
          "output": "sample output"
        },
        {
          "input": "another input",
          "output": "another output"
        }
      ]
    },
    "statement": {
      "description": "Problem description with mathematical expressions like $x^2 + y^2 = z^2$.",
      "input": "Input format description.",
      "output": "Output format description.",
      "notes": "Optional constraints and hints."
    }
  }
]
```

You can also define problems directly in `problems.typ` using Typst syntax - see the template for both approaches.

### Problem Components

- **`problem.display-name`**: The title of your problem
- **`problem.format`**: Content format - "latex", "markdown", or "markup" (default: "latex")
- **`problem.samples`**: Array of sample input/output pairs for problem clarification
- **`statement.description`**: Full problem description (supports math notation with `$...$`)
- **`statement.input`**: Format specification for input data
- **`statement.output`**: Format specification for output data
- **`statement.notes`**: Optional constraints, hints, or additional notes

**Content Format Options**:
- `"latex"`: Render content as LaTeX using mitex
- `"markdown"`: Render content as Markdown using cmarker (with mitex for math)
- `"markup"`: Render content as Typst markup

### LaTeX Support

If you set `"format": "latex"` in the problem object, the template will use the [mitex](https://github.com/mitex-rs/mitex) package to render LaTeX content. This is useful when:

- You have existing LaTeX problem statements you want to reuse
- You need more complex LaTeX features beyond Typst's math mode
- You're migrating from LaTeX-based contest systems

Example with LaTeX enabled:
```json
{
  "problem": {
    "display_name": "Complex LaTeX Problem",
    "format": "latex",
    "samples": [...]
  },
  "statement": {
    "description": "Given a function $f(x) = \\frac{x^2 + 1}{x - 1}$, calculate...",
    "input": "The input contains an integer $n$.",
    "output": "Output the result as \\\\textbf{\\frac{result}{2}}$.",
    "notes": "Constraints: $0 \\\\le n \\\\le 10^9$"
  }
}
```

### Markdown Support

If you set `"format": "markdown"` in the problem object, the template will use the [cmarker](https://github.com/typst/packages/tree/main/packages/preview/cmarker) package to render Markdown content. This is useful when:

- You want to use Markdown's simpler syntax for formatting
- You need structured content with headers, lists, and emphasis
- You want to maintain readability in the source file

Example with Markdown enabled:
```json
{
  "problem": {
    "display_name": "Markdown Example Problem",
    "format": "markdown",
    "samples": [...]
  },
  "statement": {
    "description": "For a given integer $n$, output the squares.\n\n### Examples\n- When $n = 3$, output `1 4 9`\n- When $n = 5$, output `1 4 9 16 25`\n\n### Formula\n\n$$x^2 = x \\times x$$
",
    "input": "First line contains integer $n$ ($1 \\le n \\le 1000$).",
    "output": "Output $n$ numbers separated by spaces.",
    "notes": "### Constraints\n- $1 \\le n \\le 1000$\n- Results fit in 32-bit integers\n\n### Tips\nUse iterative or formula-based approach."
  }
}
```

The Markdown renderer also supports mathematical expressions using `$...$` for inline math and `$$...$$` for display math, powered by mitex.

## Language Support

The template includes built-in support for both Chinese and English. You can switch the language using the `language` parameter in `contest-conf`:

```typst
#show: contest-conf.with(
  language: "en",  // Use "zh" for Chinese (default) or "en" for English
  title: "Programming Contest",
  problems: problems
)
```

The language setting affects all UI elements including:
- Section headers: "Input", "Output", "Examples", "Note"
- Sample table headers: "standard input", "standard output"
- Problem list title: "Problem List"
- Problem set information and warnings on the title page

**Note:** The language parameter only affects UI text. Problem content (descriptions, input/output specifications, etc.) should be written in your desired language in the problem definitions.

## API Reference

### `contest-conf`

Main template function that applies the complete contest configuration to your document.

**Parameters:**
- `title` (str, optional): Contest title (default: "这是一场 XCPC 程序设计竞赛")
- `subtitle` (str, optional): Contest subtitle (default: "试题册")
- `author` (str, optional): Contest author (default: "初梦")
- `date` (str, optional): Contest date (default: current date)
- `problems` (array, required): Array of problem objects (see Problem Structure)
- `language` (str, optional): Language for UI text - "zh" for Chinese or "en" for English (default: "zh")
- `enable-titlepage` (bool, optional): Whether to generate title page (default: `true`)
- `enable-header-footer` (bool, optional): Whether to show page headers and footers (default: `true`)
- `enable-problem-list` (bool, optional): Whether to show problem list on title page (default: `true`)
- `doc` (content, required): Document content (automatically provided by `#show` rule)

**Returns:** Formatted contest document with all problems

**Usage:**
```typst
#show: contest-conf.with(title: "My Contest", problems: problems)
```

### `render-problem`

Renders an individual problem with consistent formatting.

**Parameters:**
- `problem` (dictionary): Problem metadata containing:
  - `display-name` (str): Problem title (will be prefixed with "Problem A/B/C...")
  - `format` (str, optional): Content format - "latex", "markdown", or "markup" (default: "latex")
  - `samples` (array): Array of sample cases (each with `input` and `output`)
- `statement` (dictionary): Problem statement containing:
  - `description` (content): Problem description
  - `input` (content, optional): Input format specification
  - `output` (content, optional): Output format specification
  - `notes` (content, optional): Constraints and hints
- `language` (str, optional): Language for UI text - "zh" for Chinese or "en" for English (default: "zh")

**Returns:** Rendered problem content

**Usage:**
```typst
#for problem in problems {
  render-problem(problem.problem, problem.statement)
  pagebreak()
}
```

**Content Rendering:**
- When `format` is `"latex"`: Content rendered as LaTeX using mitex
- When `format` is `"markdown"`: Content rendered as Markdown using cmarker (with mitex for math)
- When `format` is `"markup"` or default: Content evaluated as Typst markup

### `maketitle`

Creates a professional title page for the contest.

**Parameters:**
- `title` (str, optional): Main title (default: `none`)
- `subtitle` (str, optional): Subtitle (default: `none`)
- `author` (str, optional): Author name (default: `none`)
- `date` (str, optional): Date (default: `none`)

**Returns:** Formatted title page content

**Usage:**
```typst
#maketitle(title: "Contest 2024", author: "Contest Org")
```

### `fonts`

Font configuration dictionary (not a function, but a constant).

**Contains:**
- `serif` (array): Serif font stack ("New Computer Modern Math", "FZShuSong-Z01")
- `sans` (array): Sans-serif font stack ("CMU Sans Serif", "FZHei-B01")
- `kaishu` (array): Kaishu font stack ("FZKai-Z03")
- `songti-bold` (array): Songti Bold font stack ("Source Han Serif SC")
- `mono` (array): Monospace font stack ("FiraCode Nerd Font")

**Usage:**
```typst
#text(font: fonts.sans)[Sans-serif text]
```

## License

GPL-3.0-or-later

## Contributing

Suggestions and improvements are welcome! This template aims to be a versatile starting point for contest organizers.