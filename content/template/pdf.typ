#let setup-page() = {
  set page(numbering: "1", number-align: center)
}

#let setup-layout() = {
  show: columns.with(1)
}

#let render-title(title) = align(center)[
  #block(text(weight: 700, 1.65em, title))
]

#let render-authors(authors, author-cols) = align(center, pad(
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

#let render-link(it) = text(fill: rgb(0, 127, 255))[#it]
