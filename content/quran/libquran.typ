#let quran-page(title: "", title-tl: "", title-ar: "", locator: none, body) = {
  set page(paper: "iso-b5")
  set text(font: ("Noto Serif SC", "Noto Serif CJK SC", "Noto Naskh Arabic"), lang: "zh", size: 12pt)

  [
    = #title (#text(lang: "ar", font: "Noto Naskh Arabic", title-ar), #emph[#title-tl]) #if locator != none { label(locator) }

    #body
  ]
}

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
            spacing: 1em,
            text(font: "Noto Naskh Arabic", weight: "medium", size: 26pt, lang: "ar", word.at(i)),
            stack(
              dir: ttb,
              spacing: 0.4em,
              text(dir: ltr, size: 10pt, style: "italic", translit.at(i)),
              text(dir: ltr, size: 9pt, zh.at(i)),
            )
          )
        )
      )
    }
  })
}
