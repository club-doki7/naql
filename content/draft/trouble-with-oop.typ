#import "../template/project.typ": *
#import "../symlib.typ": *

#show: project.with(
  title: "子类型，子类化，以及面向对象的大麻烦",
  author-cols: 3,
  authors: (
    (name: "Oleg Kiselyov", contrib: "作者", affiliation: "日本東北大學"),
    (name: "CAIMEO", contrib: "翻译提议", affiliation: []),
    (name: "Chuigda Whitegive", contrib: "翻译", affiliation: dd7c),
    (name: "Cousin Ze", contrib: "翻译", affiliation: dd7c),
    (name: "Claude", contrib: "校对", affiliation: "Anthropic"),
    (name: "Gemini", contrib: "校对", affiliation: "Google DeepMind")
  )
)

= 译者前言

本文是文章 #link("https://okmij.org/ftp/Computation/Subtyping/")[Subtyping, Subclassing, and Trouble with OOP] 的中文翻译，部分字句有所改动。#tm_fst("术语", "terminology") 在正文中第一次出现的地方以#tm[仿宋体（中文）]或 #emph[Italic (English)] 呈现，如果某个术语难以辨认，则总是会以#tm[仿宋体]呈现。如遇翻译或排版质量问题，请在 #link("https://github.com/club-doki7/naql/issues") 向译者报告。

// 葡萄美酒月光杯，你和掩体一起飞，炸死傻鸟君莫笑，古来填线几人回
