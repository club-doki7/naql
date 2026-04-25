== 贡献指南

感谢你对本项目的关注！以下是参与贡献的基本流程和规范。

=== 贡献流程

1. Fork 本仓库
2. 基于 `master` 创建你的分支（`git checkout -b my-change`）
3. 提交更改并推送到你的 Fork
4. 发起 Pull Request，简要描述你的更改内容

=== 参考资料

- 术语表：[glossary.tsv](./glossary.tsv)
- 记法表：[notation.typ](./notation.typ)
- 符号库：[symlib.typ](../content/symlib.typ)

=== 术语规范

项目维护了一份术语表 [glossary.tsv](./glossary.tsv)，涵盖翻译中常用术语的统一译法。贡献翻译内容时，请优先查阅术语表，确保用词一致。如需新增或修改术语，请在 PR 中一并说明理由。

术语表格式为 TSV（制表符分隔），各列依次为：术语、领域、翻译、备注、例句、例句翻译。

=== 古兰经译注排版约定

古兰经子项目的排版函数定义在 `content/quran/libquran.typ` 中。编写或修改章节内容时，请使用以下函数：

- `quran-verse()`：逐词经文排版（阿拉伯文原文 + 拉丁转写 + 中文翻译）
- `intro()`：导读框（用于章节导读，经注来源通常为 Ibn Ashur）
- `tafsir()`：经注框（主体经注，来源通常为 Tazkirul Quran）
- `hadith()`：圣训框
- `tr-comment()`：译注框（译者补充说明）
- `qa()`：问答框（来自 quran.com 的问答内容）

经注来源请使用 `libquran.typ` 中预定义的常量：

- `ibn-ashur-src`：Ibn Ashur, _Tafsir Ibn Ashur_
- `tazkirul-quran`：Maulana Wahiduddin Khan, _Tazkirul Quran_
- `maarif-al-quran`：Mufti Muhammad Shafi Usmani, _Ma'arif al-Quran_
- `ibn-kathir-src`：Ibn Kathir, _Tafsir Ibn Kathir_

=== 字体要求

构建古兰经子项目需要安装特定字体，详见 `content/quran/fonts/README.md`。

