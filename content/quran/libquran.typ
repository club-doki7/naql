#import "@preview/cuti:0.4.0": cn-fakebold as cuti

#let zh-fonts = ("Libertinus Serif", "Noto Serif SC", "Noto Serif CJK SC", "Scheherazade New")
#let fangsong-fonts = ("Libertinus Serif", "Zhuque Fangsong (technical preview)", "Scheherazade New")

#let quran-page(title: "", title-tl: "", title-ar: "", locator: none, body) = {
  set page(paper: "a4", numbering: "1", margin: (top: 2cm, bottom: 2cm))
  set text(font: zh-fonts, lang: "zh", size: 11.5pt)
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
        inset: (x: if (i == word.len() - 1) { 0.25em } else { 0.45em }, top: 0.35em, bottom: 0.35em),
        align(center,
          stack(
            dir: ttb,
            spacing: 1em,
            text(font: "Scheherazade New", weight: 600, size: if (i == word.len() - 1) { 10pt } else { 14pt }, lang: "ar", word.at(i)),
            text(dir: ltr, size: if (i == word.len() - 1) { 9pt } else { 10pt } , style: "italic", translit.at(i))
          )
        )
      )
    }
    colbreak(); set text(dir: ltr); translation
    v(0.15em)
  }, width: 100%, breakable: false)
}

#let make-box(title) = (section: "", src: "", breakable: false, content) => {
  block(inset: 0.75em, stroke: 0.5pt + black, width: 100%, breakable: breakable, [
    *#text(size: 12pt, title)* #section #h(1fr) #text(size: 10pt, src)

    #text(font: fangsong-fonts, size: 11pt, content)
  ])
  v(0.15em)
}

#let intro = make-box("导读")

#let tafsir = make-box("经注")

#let hadith = make-box("圣训")

// 如果某一章有奇数页，不要用“本页刻意留白”的占位符，而是使用一则提及该章的圣训。
// 如果没有，则尽可能使用与章节主题或部分主题有关的圣训。
// 如果再没有，选择一节符合一般意义上普世价值的圣训。
#let hadith-page(src, ar, zh) = [
  #colbreak()

  #align(horizon, hadith(src: src)[
    #align(right, text(dir: rtl, top-edge: 1.25em, ar))

    #linebreak()

    #zh
  ])
]

#let qa(section: "", src: "", q, a) = make-box("问答")(
  section: section,
  src: src
)[
  #cuti[问：]#q

  #cuti[答：]#a
]

#let bismillah = align(center, text(font: "Noto Naskh Arabic")[﷽])
#let pbuh = text(font: "Scheherazade New")[ﷺ]

#let ibn-ashur-src = [Ibn Ashur, _Tafsir Ibn Ashur_]
#let tazkirul-quran = [Wahiduddin Khan, _Tazkirul Quran_]
#let quran-com-answer(verse, answer) = text(link("https://quran.com/" + verse + "/answers/" + answer), fill: rgb("#00007F"))