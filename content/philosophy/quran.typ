#set page(paper: "iso-b5")

#let quran-word(ar, roman, tr, ar-color: rgb("#1a3a6b")) = {
  box(
    align(center,
      stack(
        dir: ttb,
        spacing: 0.4em,
        text(font: "Amiri", size: 26pt, fill: ar-color, dir: rtl, lang: "ar", ar),
        text(size: 10pt, style: "italic", roman),
        text(size: 9pt, tr),
      )
    )
  )
}

#let quran-verse(words) = {
  // 用 flex 布局从右到左排列
  set align(right)
  block(
    // RTL 排列
    stack(
      dir: rtl,
      spacing: 1em,
      ..words
    )
  )
}

// 使用
#quran-verse((
  quran-word("بِسْمِ", "bis'mi", "奉……之名"),
  quran-word("اللهِ", "l-lahi", "真主", ar-color: rgb("#c41e1e")), // 红色突出 Allah
  quran-word("الرَّحْمٰنِ", "l-raḥmāni", "至仁的"),
  quran-word("الرَّحِيْمِ", "l-raḥīmi", "至慈的"),
  quran-word("١", "1", ""),
))
