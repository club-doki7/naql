#let quran-verse(word, translit, zh) = {
  set text(dir: rtl)
  set par(justify: false, leading: 1.2em)
  block({
    for i in range(word.len()) {
      box(
        inset: (x: 0.4em),
        align(center,
          stack(
            dir: ttb,
            spacing: 0.4em,
            text(font: "Amiri", size: 26pt, lang: "ar", word.at(i)),
            text(dir: ltr, size: 10pt, style: "italic", translit.at(i)),
            text(dir: ltr, size: 9pt, zh.at(i)),
          )
        )
      )
    }
  })
}

// 使用
#quran-verse(
  ("بِسْمِ", "اللهِ", "الرَّحْمٰنِ", "الرَّحِيْمِ", "١"),
  ("bis'mi", "l-lahi", "l-raḥmāni", "l-raḥīmi", "(1)"),
  ("奉……之名", "真主", "至仁的", "至慈的", ""),
)
