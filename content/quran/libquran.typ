#let quran-page(title: "", title-tl: "", title-ar: "", locator: none, body) = {
  set page(paper: "iso-b5", numbering: "1")
  set text(font: ("Libertinus Serif", "Noto Serif SC", "Noto Serif CJK SC", "Noto Naskh Arabic"), lang: "zh", size: 12pt)

  [
    = #title (#text(lang: "ar", font: "Noto Naskh Arabic", title-ar), #text(lang: "en", font: "Libertinus Serif", style: "italic", title-tl)) #if locator != none { label(locator) }

    #body
  ]
}

#let quran-verse(word, translit, translation) = {
  block({
    set text(dir: rtl)
    for i in range(word.len()) {
      box(
        inset: (x: 0.4em),
        align(center,
          stack(
            dir: ttb,
            spacing: 1em,
            text(font: "Noto Naskh Arabic", weight: "medium", size: 20pt, lang: "ar", word.at(i)),
            text(dir: ltr, size: 10pt, style: "italic", translit.at(i))
          )
        )
      )
    }
    colbreak()
    set text(dir: ltr)
    translation
  }, width: 100%, breakable: false)
}
