#let inside-figure = state("_tola-inside-figure", false)

// Inline math baseline fix (pin + measure)
#let bounded(eq) = text(top-edge: "bounds", bottom-edge: "bounds", eq)
#let equations-height-dict = state("eq_height_dict", (:))
#let is-inside-pin = state("inside_pin", false)

#let pin(label) = context {
  let height = here().position().y
  equations-height-dict.update(dict => {
    if label in dict.keys() or height < 0.000001pt {
      dict
    } else {
      dict.insert(label, height)
      dict
    }
  })
}

#let add-pin(eq) = {
  let label = repr(eq)
  is-inside-pin.update(true)
  $ inline(pin(label)#bounded(eq)) $
  is-inside-pin.update(false)
}

#let to-em(pt) = str(pt / text.size.pt()) + "em"

#let math-span(class: "", style: none, body) = {
  let attrs = (role: "math")
  if class != "" {
    attrs.insert("class", class)
  }
  if style != none {
    attrs.insert("style", style)
  }
  html.span(body, ..attrs)
}

#let render-inline-math(eq, class: "") = context {
  if is-inside-pin.get() {
    return math-span(class: class)[#html.frame(bounded(eq))]
  }

  let label = repr(eq)
  let cache = equations-height-dict.final()
  if label in cache.keys() {
    let reference-height = cache.at(label, default: none)
    equations-height-dict.update(dict => {
      dict.insert(label, reference-height)
      dict
    })

    let measured-height = measure(bounded(eq)).height
    let shift = measured-height - reference-height
    let style = "vertical-align: -" + to-em(shift.pt()) + ";"
    math-span(class: class, style: style)[#html.frame(bounded(eq))]
  } else {
    math-span(class: class)[#box(html.frame(add-pin(eq)))]
  }
}

#let setup-page() = {}

#let html-show-fix(body) = {
  show figure: it => context {
    if target() == "html" {
      inside-figure.update(true)
      let wrapped = html.figure()[#it]
      inside-figure.update(false)
      wrapped
    } else { it }
  }

  show math.equation.where(block: false): it => context {
    if target() == "html" and not inside-figure.get() {
      render-inline-math(it)
    } else { it }
  }

  show math.equation.where(block: true): it => context {
    if target() == "html" and not inside-figure.get() {
      html.div(role: "math")[#html.frame(it)]
    } else { it }
  }

  [
    #html.elem("style", "a, a:visited { color: rgb(0, 127, 255); text-decoration: none; }")
    #body
  ]
}

#let render-title(title) = html.h1(style: "text-align: center")[#title]

#let render-authors(authors, author-cols) = if authors.len() > 0 [
  #html.div(
    style: "display: grid; grid-template-columns: repeat("
      + str(author-cols)
      + ", minmax(0, 1fr)); gap: 0.7em 1.4em; margin: 1.1em auto 1.6em auto; text-align: center; color: #6a6a6a;",
  )[
    #for author in authors {
      html.div[
        #html.div(style: "font-weight: 700; color: #333;")[#author.name]
        #html.div[#author.contrib]
        #html.div[#author.affiliation]
      ]
    }
  ]
]


#let render-link(it) = it
