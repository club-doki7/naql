#import "@preview/cuti:0.4.0": cn-fakebold as cuti

#let zh-fonts = ("Libertinus Serif", "Noto Serif CJK SC", "Scheherazade New")
#let fangsong-fonts = ("Libertinus Serif", "Zhuque Fangsong (technical preview)")

#let quran-page(title: "", title-tl: "", title-ar: "", locator: none, body) = {
  set page(paper: "iso-b5", numbering: "1")
  set text(font: zh-fonts, lang: "zh", size: 11pt)
  show heading: set align(center)

  [
    = #title (#text(lang: "ar", font: "Scheherazade New", title-ar), #text(lang: "en", font: "Libertinus Serif", style: "italic", title-tl)) #if locator != none { label(locator) }
    #v(1em)

    #body
  ]
}

#let quran-verse(word, translit, translation) = {
  block({
    set text(dir: rtl)
    for i in range(word.len()) {
      box(
        inset: (x: 0.5em, top: 0.6em, bottom: 0.4em),
        align(center,
          stack(
            dir: ttb,
            spacing: 1.5em,
            text(font: "Scheherazade New", weight: "medium", size: 20pt, lang: "ar", word.at(i)),
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

#let make-box(title) = (section: "", breakable: false, content) => {
  block(inset: 0.75em, stroke: 0.5pt + black, width: 100%, breakable: breakable, [
    *#title* #section

    #text(font: fangsong-fonts, size: 10pt, content)
  ])
}

#let intro = make-box("导读")

#let tafsir = make-box("经注")

#let qa(q, a) = make-box("问答")[
  #cuti[问：]#q

  #cuti[答：]#a
]

#let bismillah = align(center)[﷽]
