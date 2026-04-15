#import "@preview/cuti:0.4.0": cn-fakebold as cuti

#let zh-fonts = ("Libertinus Serif", "Noto Serif SC", "Noto Serif CJK SC")
#let fangsong-fonts = ("Libertinus Serif", "Zhuque Fangsong (technical preview)")
#let mono-fonts = ("LXGW Bright Code",)

#let index-page(numbering: "i", body) = {
  set page(paper: "a4", numbering: numbering, margin: (top: 2.25cm, bottom: 2cm))
  set text(font: zh-fonts, lang: "zh", size: 11pt)
  show heading: set align(center)
  counter(footnote).update(1)

  body
}

#let chapter-page(title: "", title-en: "", locator: none, body) = {
  set page(paper: "a4", numbering: "1", margin: (top: 2.25cm, bottom: 2cm))
  set text(font: zh-fonts, lang: "zh", size: 11pt)
  show heading: set align(center)
  counter(footnote).update(1)

  [
    = #title (#text(lang: "en", font: "Libertinus Serif", style: "italic", title-en)) #if locator != none { label(locator) }
    #v(1em)

    #body
  ]
}

#let make-box(title) = (src: "", breakable: false, content) => {
  block(inset: 0.75em, stroke: 0.5pt + black, width: 100%, breakable: breakable, [
    *#text(size: 12pt, title)* #h(1fr) #text(size: 10pt, src)

    #text(font: fangsong-fonts, size: 11pt, content)
  ])
  v(0.15em)
}

#let defn = make-box("定义")

#let theorem = make-box("定理")

#let example = make-box("示例")

#let tr-comment = make-box("译注")

#let remark = make-box("备注")
