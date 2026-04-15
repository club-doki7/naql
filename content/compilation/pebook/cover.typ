// Partial Evaluation and Program Generation — Book Cover (wrap-around: back + spine + front)
// A3-class sheet with bleed, for an A4-sized book interior.
//
// Usage:
//   #import "cover.typ": cover-page
//   #show: cover-page                          // default 35mm spine
//   #show: cover-page.with(spine-width: 28mm)  // custom spine width

// ── Colours ─────────────────────────────────────────────────────────
#let cover-bg    = rgb("#0F1A2E")   // deep dark navy / midnight blue
#let silver      = rgb("#C0C8D8")   // cool silver-blue
#let silver-light = rgb("#D8DFE8")
#let silver-dim  = rgb("#7A8494")

// ── Helpers ─────────────────────────────────────────────────────────
#let _put(dx, dy, body) = place(top + left, dx: dx, dy: dy, body)

#let _h-rule(width) = {
  let dot-r = 2.5pt
  box(width: width, align(horizon + center, stack(dir: ltr, spacing: 1fr,
    circle(radius: dot-r, fill: silver, stroke: none),
    line(length: width - 6 * dot-r, stroke: 0.8pt + silver),
    circle(radius: dot-r, fill: silver, stroke: none),
  )))
}

#let _diamond(size: 6pt) = {
  rotate(45deg, square(size: size, fill: silver, stroke: none))
}

// ── Main entry point ────────────────────────────────────────────────
#let cover-page(
  spine-text: "",
  spine-width:  35mm,
  bleed:        3mm,
  panel-width:  210mm,
  panel-height: 297mm,
  body,
) = {
  let total-width  = 2 * bleed + panel-width + spine-width + panel-width
  let total-height = 2 * bleed + panel-height

  set page(
    width:  total-width,
    height: total-height,
    margin: 0pt,
    fill:   cover-bg,
  )

  // ── Trim / crop marks ───────────────────────────────────────────
  let mark-len = 6mm
  let mark-stroke = 0.25pt + rgb("#999999")

  // Top-left
  _put(bleed, 0pt, line(length: mark-len, angle: 90deg, stroke: mark-stroke))
  _put(0pt, bleed, line(length: mark-len, stroke: mark-stroke))
  // Top-right
  _put(total-width - bleed, 0pt, line(length: mark-len, angle: 90deg, stroke: mark-stroke))
  _put(total-width - mark-len, bleed, line(length: mark-len, stroke: mark-stroke))
  // Bottom-left
  _put(bleed, total-height, line(length: mark-len, angle: -90deg, stroke: mark-stroke))
  _put(0pt, total-height - bleed, line(length: mark-len, stroke: mark-stroke))
  // Bottom-right
  _put(total-width - bleed, total-height, line(length: mark-len, angle: -90deg, stroke: mark-stroke))
  _put(total-width - mark-len, total-height - bleed, line(length: mark-len, stroke: mark-stroke))

  // ── Spine fold marks ──────────────────────────────────────────
  let spine-left  = bleed + panel-width
  let spine-right = spine-left + spine-width
  _put(spine-left, 0pt, line(length: bleed, angle: 90deg, stroke: mark-stroke))
  _put(spine-left, total-height - bleed, line(length: bleed, angle: 90deg, stroke: mark-stroke))
  _put(spine-right, 0pt, line(length: bleed, angle: 90deg, stroke: mark-stroke))
  _put(spine-right, total-height - bleed, line(length: bleed, angle: 90deg, stroke: mark-stroke))

  // ════════════════════════════════════════════════════════════════
  //  FRONT COVER  (right panel)
  // ════════════════════════════════════════════════════════════════
  let fc-left = spine-right
  let fc-cx   = fc-left + panel-width / 2

  // ── Outer border frame ────────────────────────────────────────
  let frame-inset = 12mm
  _put(fc-left + frame-inset, bleed + frame-inset,
    rect(
      width:  panel-width - 2 * frame-inset,
      height: panel-height - 2 * frame-inset,
      stroke: (paint: silver, thickness: 1.6pt),
      radius: 2pt,
      fill: none,
    )
  )
  // Inner border (double-rule effect)
  let frame-inset2 = frame-inset + 4mm
  _put(fc-left + frame-inset2, bleed + frame-inset2,
    rect(
      width:  panel-width - 2 * frame-inset2,
      height: panel-height - 2 * frame-inset2,
      stroke: (paint: silver-dim, thickness: 0.6pt),
      radius: 2pt,
      fill: none,
    )
  )

  // ── Corner ornaments (small diamonds) ─────────────────────────
  let corner-off = frame-inset + 2mm
  for (cx, cy) in (
    (fc-left + corner-off, bleed + corner-off),
    (fc-left + panel-width - corner-off, bleed + corner-off),
    (fc-left + corner-off, bleed + panel-height - corner-off),
    (fc-left + panel-width - corner-off, bleed + panel-height - corner-off),
  ) {
    _put(cx - 4pt, cy - 4pt, _diamond(size: 6pt))
  }

  // ── Title block (centred on front cover) ──────────────────────
  let title-y = bleed + 55mm

  // Lambda symbol as decorative element
  _put(fc-left, title-y,
    box(width: panel-width, align(center,
      text(
        font: "Libertinus Math",
        size: 48pt,
        fill: silver-dim,
        $lambda$
      )
    ))
  )

  // Decorative rule
  _put(fc-left + 35mm, title-y + 38mm,
    _h-rule(panel-width - 70mm)
  )

  // Chinese title: 部分求值与程序生成
  _put(fc-left, title-y + 52mm,
    box(width: panel-width, align(center,
      text(
        font: ("Noto Serif SC", "Noto Serif CJK SC"),
        size: 32pt,
        fill: silver,
        weight: "bold",
        tracking: 0.1em,
        lang: "zh",
        "部分求值与程序生成"
      )
    ))
  )

  // Decorative diamond cluster
  _put(fc-cx - 18pt, title-y + 100mm, {
    stack(dir: ltr, spacing: 8pt,
      _diamond(size: 4pt),
      _diamond(size: 6pt),
      _diamond(size: 4pt),
    )
  })

  // English title
  _put(fc-left, title-y + 115mm,
    box(width: panel-width, align(center,
      text(
        font: "Libertinus Serif",
        size: 18pt,
        fill: silver,
        style: "italic",
        lang: "en",
        "Partial Evaluation and"
      )
    ))
  )
  _put(fc-left, title-y + 130mm,
    box(width: panel-width, align(center,
      text(
        font: "Libertinus Serif",
        size: 18pt,
        fill: silver,
        style: "italic",
        lang: "en",
        "Automatic Program Generation"
      )
    ))
  )

  // Authors
  _put(fc-left, title-y + 158mm,
    box(width: panel-width, align(center,
      text(
        font: "Libertinus Serif",
        size: 12pt,
        fill: silver-dim,
        lang: "en",
        "Neil D. Jones  ·  Carsten K. Gomard  ·  Peter Sestoft"
      )
    ))
  )

  // Subtitle
  _put(fc-left, title-y + 178mm,
    box(width: panel-width, align(center,
      text(
        font: ("Noto Serif SC", "Noto Serif CJK SC"),
        size: 14pt,
        fill: silver-dim,
        lang: "zh",
        "汉语编译本"
      )
    ))
  )

  // Lower decorative rule
  _put(fc-left + 35mm, title-y + 196mm,
    _h-rule(panel-width - 70mm)
  )

  // ════════════════════════════════════════════════════════════════
  //  SPINE  (centre strip)
  // ════════════════════════════════════════════════════════════════
  let sp-cx = spine-left + spine-width / 2

  // Chinese title on spine
  _put(spine-left, bleed + panel-height / 2,
    box(width: spine-width, align(center,
      text(
        font: ("Noto Serif SC", "Noto Serif CJK SC"),
        size: 20pt,
        fill: silver,
        lang: "zh",
        spine-text
      )
    ))
  )

  // Small diamonds at spine top & bottom
  _put(spine-left, bleed + 18mm, box(width: spine-width, align(center, _diamond(size: 5pt))))
  _put(spine-left, bleed + panel-height - 18mm, box(width: spine-width, align(center, _diamond(size: 5pt))))

  // Spine border lines
  _put(spine-left, bleed + 10mm,
    line(length: panel-height - 20mm, angle: 90deg, stroke: 0.4pt + silver-dim)
  )
  _put(spine-right, bleed + 10mm,
    line(length: panel-height - 20mm, angle: 90deg, stroke: 0.4pt + silver-dim)
  )

  // ════════════════════════════════════════════════════════════════
  //  BACK COVER  (left panel)
  // ════════════════════════════════════════════════════════════════
  let bc-left = bleed
  let bc-cx   = bc-left + panel-width / 2

  // ── Back cover frame ──────────────────────────────────────────
  _put(bc-left + frame-inset, bleed + frame-inset,
    rect(
      width:  panel-width - 2 * frame-inset,
      height: panel-height - 2 * frame-inset,
      stroke: (paint: silver-dim, thickness: 0.8pt),
      radius: 2pt,
      fill: none,
    )
  )

  // ── Centred quote (Futamura projections) ──────────────────────
  _put(bc-left, bleed + 80mm,
    box(width: panel-width, align(center, {
      text(
        font: "Libertinus Serif",
        size: 14pt,
        fill: silver,
        style: "italic",
        lang: "en",
        "A partial evaluator is an automatic program generator"
      )
      v(0.6em)
      text(
        font: "Libertinus Serif",
        size: 14pt,
        fill: silver,
        style: "italic",
        lang: "en",
        "that generates program generators."
      )
      v(1.2em)
      text(
        font: ("Noto Serif SC", "Noto Serif CJK SC"),
        size: 12pt,
        fill: silver-dim,
        lang: "zh",
        "部分求值器是一种自动生成程序生成器的程序生成器。"
      )
      v(0.6em)
      text(
        font: "Libertinus Serif",
        size: 10pt,
        fill: silver-dim,
        style: "italic",
        lang: "en",
        "— Yoshihiko Futamura"
      )
    }))
  )

  // ── Brief description ─────────────────────────────────────────
  _put(bc-left + 25mm, bleed + 160mm,
    box(width: panel-width - 50mm, align(center,
      text(
        font: ("Noto Serif SC", "Noto Serif CJK SC"),
        size: 10.5pt,
        fill: silver-dim,
        lang: "zh",
        "本书系统介绍部分求值的理论与实践，涵盖从基本概念到" +
        "自应用、Futamura 映射及编译器生成等核心主题，" +
        "旨在为中文读者提供一份兼顾理论深度与实践应用的参考文本。"
      )
    ))
  )

  // ── Back cover lower decorative rule ──────────────────────────
  _put(bc-left + 40mm, bleed + panel-height - 50mm,
    _h-rule(panel-width - 80mm)
  )

  body
}
