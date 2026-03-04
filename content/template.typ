#let en-fonts = ("Libertinus Serif",)
#let zh-fonts = ("Libertinus Serif", "Noto Serif", "Noto Serif SC", "Noto Serif CJK SC")
#let math-fonts = ("Libertinus Math", "Zhuque Fangsong (technical preview)")
#let monospace-fonts = ("LXGW Bright Code",)
#let tm-fonts = ("Libertinus Serif", "Zhuque Fangsong (technical preview)")

#let project(title: "", authors: (), author-cols: 3, body) = {
  set document(author: authors.map(a => a.name), title: title)
  set page(numbering: "1", number-align: center)
  set text(lang: "en", font: en-fonts)
  set text(lang: "zh", font: zh-fonts)

  set par(spacing: 1.2em)
  set par(leading: 0.58em)

  show link: set text(fill: rgb(0, 127, 255))

  show raw: set text(font: monospace-fonts, size: 10pt, weight: 350, ligatures: false, features: (liga: 0,  dlig: 0, clig: 0, calt: 0, locl: 0))
  show raw.where(block: true): set block(breakable: false)
  show raw.where(block: true): pad.with(left: 2em, right: 2em)

  show math.equation: set text(font: math-fonts)
  show math.equation.where(block: true): set block(breakable: false)

  align(center)[
    #block(text(weight: 700, 1.65em, title))
  ]

  align(center, pad(
    top: 2em,
    bottom: 2em,
    x: 4em,
    grid(
      align: center,
      columns: (1fr,) * calc.min(author-cols, authors.len()),
      gutter: 1em,
      ..authors.map(author => align(center)[
        *#author.name* \
        #author.contrib \
        #author.affiliation
      ]),
    ),
  ))

  set par(justify: true)
  show: columns.with(1)

  body
}

#let tm_fst(zh, xpln, skip_paren: false) = if not skip_paren {
  text(font: tm-fonts, style: "italic")[#zh (#xpln)]
} else {
  text(font: tm-fonts, style: "italic")[#zh #xpln]
}

#let tm_lnk(zh, xpln, url, skip_paren: false) = link(url, tm_fst(zh, xpln, skip_paren))

#let tm(zh) = text(font: tm-fonts, style: "italic")[#zh]

#let dt = $. thin$
#let tdt = $thin . thin$

#let early-draft-note = [
⚠ 注意：本文为早期草稿，内容不完且有措误，且#text(tracking: -0.15em)[排版]质量差。

⚠ Note: this is an early draft. It's known to be incomplet and incorrekt, and it has lots of b#text(tracking: -0.15em)[ad] fo#text(tracking: -0.15em)[rm]atting.
]
