#import "./html.typ" as html-side
#import "./pdf.typ" as pdf-side

#let en-fonts = ("Libertinus Serif",)
#let zh-fonts = ("Libertinus Serif", "Noto Serif", "Noto Serif SC", "Noto Serif CJK SC")
#let math-fonts = ("Libertinus Math", "Zhuque Fangsong (technical preview)")
#let monospace-fonts = ("LXGW Bright Code",)
#let tm-fonts = ("Libertinus Serif", "Zhuque Fangsong (technical preview)")

#let project(title: "", authors: (), author-cols: 3, body) = {
  set document(author: authors.map(a => a.name), title: title)

  show link: it => context {
    if target() == "html" {
      html-side.render-link(it)
    } else {
      pdf-side.render-link(it)
    }
  }

  show quote: it => context {
    if target() == "html" {
      html.blockquote(style: "margin: 1em 0 1em 1em; text-align: justify;")[
        #context {
          // triggers typst to wrap content in <p> </p> tags
          set par(justify: true)
          it.body
        }
        #if it.attribution != none [
          #html.div(style: "margin-top: 0.45em; text-align: right;")[
            #text("―")~#it.attribution
          ]
        ]
      ]
    } else {
      it
    }
  }

  show colbreak: it => context {
    if target() == "html" { none } else { it }
  }
  show pad: it => context {
    if target() == "html" { it.body } else { it }
  }

  show footnote.entry: set text(font: zh-fonts)

  context {
    let header-and-body = {
      if target() == "html" {
        html-side.render-title(title)
        html-side.render-authors(authors, author-cols)
      } else {
        pdf-side.render-title(title)
        pdf-side.render-authors(authors, author-cols)
      }
      body
    }

    if target() == "html" {
      set text(lang: "zh")
      show math.equation: set text(font: math-fonts)
      show: html-side.html-show-fix
      header-and-body
    } else {
      set page(numbering: "1", number-align: center)
      show: columns.with(1)
      set text(lang: "en", font: en-fonts)
      set text(lang: "zh", font: zh-fonts)
      set par(spacing: 1.2em)
      set par(leading: 0.58em)
      set par(justify: true)
      show raw: set text(font: monospace-fonts, size: 10pt, weight: 350, ligatures: false, features: (
        liga: 0,
        dlig: 0,
        clig: 0,
        calt: 0,
        locl: 0,
      ))
      show raw.where(block: true): set block(breakable: false)
      show raw.where(block: true): pad.with(left: 2em, right: 2em)
      show math.equation: set text(font: math-fonts)
      show math.equation.where(block: true): set block(breakable: false)

      header-and-body
    }
  }
}

#let tm_fst(zh, xpln, skip_paren: false) = context {
  let content = if not skip_paren { [#zh (#xpln)] } else { [#zh #xpln] }
  if target() == "html" {
    emph(content)
  } else {
    text(font: tm-fonts, style: "italic", content)
  }
}

#let tm_lnk(zh, xpln, url, skip_paren: false) = link(url, tm_fst(zh, xpln, skip_paren: skip_paren))

#let tm(zh) = context {
  if target() == "html" {
    emph[#zh]
  } else {
    text(font: tm-fonts, style: "italic")[#zh]
  }
}

#let stress(t) = context {
  if target() == "html" {
    emph[#t]
  } else {
    text(font: tm-fonts, style: "italic")[#t]
  }
}

#let fangsong(t) = context {
  if target() == "html" {
    emph[#t]
  } else {
    text(font: tm-fonts, style: "italic")[#t]
  }
}

#let dt = $. thin$
#let tdt = $thin . thin$

#let early-draft-note = [
  ⚠ 注意：本文为早期草稿，内容不完且有措误，且#text(tracking: -0.15em)[排版]质量差。

  ⚠ Note: this is an early draft. It's known to be incomplet and incorrekt, and it has lots of b#text(tracking: -0.15em)[ad] fo#text(tracking: -0.15em)[rm]atting.
]
