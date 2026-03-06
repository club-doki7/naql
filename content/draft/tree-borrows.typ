#import "../template/project.typ": *
#import "../symlib.typ": *

#show: project.with(
  title: "树形借用模型",
  author-cols: 3,
  authors: (
    (name: "Neven Villani", contrib: "第一作者", affiliation: "格勒诺布尔大学"),
    (name: "Johannes Hostert", contrib: "第一作者", affiliation: "苏黎世联邦理工大学"),
    (name: "Derek Dreyer", contrib: "作者", affiliation: "马克斯-普朗克\n软件系统研究所"),
    (name: "Ralf Jung", contrib: "作者", affiliation: "苏黎世联邦理工大学"),
    (name: "Chuigda Whitegive", contrib: "翻译", affiliation: dd7c),
    (name: "Claude", contrib: "校对", affiliation: "Anthropic")
  )
)

#show raw.where(lang: none): it => raw(it.text, lang: "rust", block: it.block)

#early-draft-note

= 译者前言

本文是文章 #link("https://dl.acm.org/doi/pdf/10.1145/3735592?download=true")[Tree borrows] 的中文翻译，部分字句有所改动。原文以#link("https://creativecommons.org/licenses/by/4.0/")[CC-BY 4.0] 协议发布。#tm_fst("术语", "terminology") 在正文中第一次出现的地方以#tm[仿宋体（中文）]或 #emph[Italic (English)] 呈现，如果某个术语难以辨认，则总是会以#tm[仿宋体]呈现。如遇翻译或排版质量问题，请在 #link("https://github.com/club-doki7/naql/issues") 向译者报告。

#tm_fst("栈式借用", "Stacked Borrows") 的概念早在 2020 年就已被提出，而#tm_fst("树形借用", "Tree Borrows") 的概念也在 2025 年得到了形式化。遗憾的是，这些工作在中文 Rust 社区并未得到应有的广泛认知。许多人将 `unsafe` 视作可以为所欲为的免死金牌，在使用 `unsafe` 时忽视别名规则。译者翻译本文的主要动机之一便是纠正这一常见误解。
