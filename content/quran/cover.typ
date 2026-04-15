// Noble Quran — Book Cover (wrap-around: back + spine + front)
// A3-class sheet with bleed, for an A4-sized book interior.
//
// Usage:
//   #import "cover.typ": cover-page
//   #show: cover-page                          // default 35mm spine
//   #show: cover-page.with(spine-width: 28mm)  // custom spine width
//
// Adjust `spine-width` to match the actual page count / paper stock.

// ── Colours ─────────────────────────────────────────────────────────
#let cover-bg    = rgb("#0C2E2E")   // deep dark teal / green-blue
#let gold        = rgb("#C9A84C")   // classical gold
#let gold-light  = rgb("#E0C872")
#let gold-dim    = rgb("#8A7234")

// ── Helpers ─────────────────────────────────────────────────────────
#let _put(dx, dy, body) = place(top + left, dx: dx, dy: dy, body)

#let _h-rule(width) = {
  let dot-r = 2.5pt
  box(width: width, align(horizon + center, stack(dir: ltr, spacing: 1fr,
    circle(radius: dot-r, fill: gold, stroke: none),
    line(length: width - 6 * dot-r, stroke: 0.8pt + gold),
    circle(radius: dot-r, fill: gold, stroke: none),
  )))
}

#let _diamond(size: 6pt) = {
  rotate(45deg, square(size: size, fill: gold, stroke: none))
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

  // ── Outer golden border frame ─────────────────────────────────
  let frame-inset = 12mm
  _put(fc-left + frame-inset, bleed + frame-inset,
    rect(
      width:  panel-width - 2 * frame-inset,
      height: panel-height - 2 * frame-inset,
      stroke: (paint: gold, thickness: 1.6pt),
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
      stroke: (paint: gold-dim, thickness: 0.6pt),
      radius: 2pt,
      fill: none,
    )
  )

  // ── Corner ornaments (small golden diamonds) ──────────────────
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
  let title-y = bleed + 60mm

  // بسم اللّٰه الرحمٰن الرحيم
  _put(fc-left, title-y,
    box(width: panel-width, align(center,
      text(
        font: "Noto Naskh Arabic",
        size: 16pt,
        fill: gold-light,
        dir: rtl,
        lang: "ar",
        "بِسۡمِ ٱللَّهِ ٱلرَّحۡمَـٰنِ ٱلرَّحِيمِ"
      )
    ))
  )

  // Decorative rule
  _put(fc-left + 35mm, title-y + 28mm,
    _h-rule(panel-width - 70mm)
  )

  // Main Arabic title: القرآن الكريم
  _put(fc-left, title-y + 42mm,
    box(width: panel-width, align(center,
      text(
        font: "Noto Naskh Arabic",
        size: 52pt,
        fill: gold,
        weight: "bold",
        dir: rtl,
        lang: "ar",
        "ٱلۡقُرۡءَانُ ٱلۡكَرِيمُ"
      )
    ))
  )

  // Decorative diamond cluster
  _put(fc-cx - 18pt, title-y + 105mm, {
    stack(dir: ltr, spacing: 8pt,
      _diamond(size: 4pt),
      _diamond(size: 6pt),
      _diamond(size: 4pt),
    )
  })

  // Chinese title
  _put(fc-left, title-y + 120mm,
    box(width: panel-width, align(center,
      text(
        font: ("Noto Serif SC", "Noto Serif CJK SC"),
        size: 28pt,
        fill: gold,
        weight: "bold",
        tracking: 0.15em,
        lang: "zh",
        "尊贵的古兰经"
      )
    ))
  )

  // Subtitle: translation & commentary
  _put(fc-left, title-y + 158mm,
    box(width: panel-width, align(center,
      text(
        font: ("Noto Serif SC", "Noto Serif CJK SC"),
        size: 14pt,
        fill: gold-dim,
        lang: "zh",
        "汉语译注合编本"
      )
    ))
  )

  // Lower decorative rule
  _put(fc-left + 35mm, title-y + 176mm,
    _h-rule(panel-width - 70mm)
  )

  // "The Noble Quran" in English
  _put(fc-left, title-y + 186mm,
    box(width: panel-width, align(center,
      text(
        font: "Libertinus Serif",
        size: 16pt,
        fill: gold-light,
        style: "italic",
        lang: "en",
        "The Noble Quran"
      )
    ))
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
        fill: gold,
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
    line(length: panel-height - 20mm, angle: 90deg, stroke: 0.4pt + gold-dim)
  )
  _put(spine-right, bleed + 10mm,
    line(length: panel-height - 20mm, angle: 90deg, stroke: 0.4pt + gold-dim)
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
      stroke: (paint: gold-dim, thickness: 0.8pt),
      radius: 2pt,
      fill: none,
    )
  )

  // ── Centred Quran verse (Al-Hijr 15:9) ────────────────────────
  _put(bc-left, bleed + 90mm,
    box(width: panel-width, align(center, {
      text(
        font: "Noto Naskh Arabic",
        size: 22pt,
        fill: gold,
        dir: rtl,
        lang: "ar",
        "إِنَّا نَحۡنُ نَزَّلۡنَا ٱلذِّكۡرَ وَإِنَّا لَهُۥ لَحَـٰفِظُونَ"
      )
      v(1.2em)
      text(
        font: ("Noto Serif SC", "Noto Serif CJK SC"),
        size: 12pt,
        fill: gold-dim,
        lang: "zh",
        "我确已降示教诲，我确是教诲的保护者。"
      )
      v(0.6em)
      text(
        font: "Libertinus Serif",
        size: 10pt,
        fill: gold-dim,
        style: "italic",
        lang: "en",
        "— Al-Hijr 15 : 9"
      )
    }))
  )

  // ── Brief description ─────────────────────────────────────────
  _put(bc-left + 25mm, bleed + 160mm,
    box(width: panel-width - 50mm, align(center,
      text(
        font: ("Noto Serif SC", "Noto Serif CJK SC"),
        size: 10.5pt,
        fill: gold-dim,
        lang: "zh",
        "本书以马坚先生译本为底本，辅以三部经典经注的择译与整理，" +
        "附有译注和问答，旨在为中文读者提供一份" +
        "兼顾经文翻译与经注解读的参考文本。"
      )
    ))
  )

  // ── Back cover lower decorative rule ──────────────────────────
  _put(bc-left + 40mm, bleed + panel-height - 50mm,
    _h-rule(panel-width - 80mm)
  )

  body
}
