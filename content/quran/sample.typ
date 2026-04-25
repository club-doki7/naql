#import "./cover.typ": cover-page

#{
  show: cover-page.with(spine-width: 2cm, spine-text: "I")
}

#include "cover2.typ"

#import "./libquran.typ": index-page

#show: index-page.with(numbering: none)

*注意：本册为样品，内容不完且有措误，且#text(tracking: -0.15em)[排版]质量差*

#outline(title: "目录")
#colbreak()

#counter(page).update(1)

#include "preface.typ"

#counter(page).update(1)

#include "./surahs/001-al-fatihah.typ"
#include "./surahs/002-al-baqarah.typ"
#include "./surahs/003-ali--imran.typ"
#include "./surahs/004-an-nisa.typ"