# 古兰经汉语译注合编本

本子项目是一部基于 [Typst](https://typst.app/) 排版系统的《古兰经》汉语译注合编本，旨在为中文读者提供一份兼顾经文翻译与经注（tafsir）解读的参考文本。

## 内容概要

- 经文翻译以马坚先生的译本为底本，并做了字形规范化和措辞修订
- 经注取材于三部经典注释：
  - **Tazkirul Quran**（毛拉纳·瓦希杜丁·坎著）——经注主体
  - **Tafsir Ibn Ashur**（伊本·阿舒尔著）——各章导读
  - **Ma'arif al-Quran**（穆夫提·穆罕默德·沙菲著）——教法细节
- 附带译注和来自 [quran.com](https://quran.com) 的问答内容

## 目录结构

```
content/quran/
├── index.typ          # 全本入口（114 章）
├── sample.typ         # 样本入口（前 3 章，用于预览）
├── libquran.typ       # 核心排版库（页面布局、经文排版、经注框等）
├── cover.typ          # 封面（A3 展开式，含书脊）
├── cover2.typ         # 内封面
├── preface.typ        # 译者序
├── surahs/            # 各章经文（001-al-fatihah.typ ~ 114-*.typ）
├── fonts/             # 字体文件（见 fonts/README.md）
├── fonts-tajweed/     # 泰吉维德字体
├── crawler/           # 数据爬虫（从 quran.com 抓取并生成 .typ 文件）
└── reading/           # 参考论文
```

## 依赖

### Typst

需要安装 [Typst](https://github.com/typst/typst)。项目使用了 `@preview/cuti:0.4.0` 包（Typst 会自动下载）。

### 字体

以下字体需要预先安装：

| 字体 | 用途 |
|------|------|
| Libertinus Serif | 西文正文 |
| Noto Serif SC / Noto Serif CJK SC | 中文正文 |
| Scheherazade New | 阿拉伯文辅助（太斯米、先知祝福语等） |
| Noto Naskh Arabic | 阿拉伯文章节标题 |
| QCF2 系列（QCF2001 ~ QCF2604） | 古兰经逐词原文排版（Quran Print Color v2） |

QCF2 字体的获取方式见 [fonts/README.md](fonts/README.md)。

## 构建

构建样本（前 3 章）：

```sh
typst compile content/quran/sample.typ
```

构建全本（114 章）：

```sh
typst compile content/quran/index.typ
```

> 注意：`sample.typ` 自述"内容不完且有措误，且排版质量差"，仅供预览参考。

## 核心排版函数（libquran.typ）

| 函数 | 用途 |
|------|------|
| `index-page()` | 目录页布局 |
| `quran-page()` | 各章页面布局（含中/阿/拉丁标题） |
| `quran-verse()` | 逐词经文排版（阿拉伯文原文 + 拉丁转写 + 中文翻译） |
| `intro()` | 导读框 |
| `tafsir()` | 经注框 |
| `hadith()` | 圣训框 |
| `tr-comment()` | 译注框 |
| `qa()` | 问答框（含 quran.com 链接） |
| `hadith-page()` | 奇数页圣训填充 |

## 当前状态

项目仍在进行中。全部 114 章的文件已创建，但各章的经注、导读、问答完成度不一。
