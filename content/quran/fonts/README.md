The Quran commentary translation project uses the QPC v2 ttf fonts.

Download from: https://qul.tarteel.ai/resources/font/249 (login needed).

## Required Fonts

| Font | Purpose | Source |
|------|---------|--------|
| QCF2 series (QCF2001 ~ QCF2604) | Per-page Quran text rendering in `quran-verse()` | [Tarteel QPC v2](https://qul.tarteel.ai/resources/font/249) (login needed) |
| Noto Naskh Arabic | Arabic surah titles in `quran-page()` | [Google Fonts](https://fonts.google.com/noto/specimen/Noto+Naskh+Arabic) |
| Scheherazade New | Bismillah (﷽) and PBUH symbol (ﷺ) | [SIL International](https://software.sil.org/scheherazade/) |
| Noto Serif SC / Noto Serif CJK SC | Chinese body text | [Google Fonts](https://fonts.google.com/noto/specimen/Noto+Serif+SC) |
| Libertinus Serif | Latin body text | [GitHub](https://github.com/alerque/libertinus) |
| Zhuque Fangsong (technical preview) | Fangsong style in annotation boxes | [GitHub](https://github.com/nickhsine/zhuque-fangsong) |

## Installation

Place the font files in this directory (`content/quran/fonts/`) or install them system-wide. Typst will search both locations.

For the QCF2 series, after downloading the archive from Tarteel, extract all `.ttf` files (QCF2001.ttf through QCF2604.ttf) into this directory.
