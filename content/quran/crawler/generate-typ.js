import { readFile, writeFile, readdir, mkdir } from 'fs/promises'
import { join } from 'path'

const OUTPUT_DIR = 'output'
const TYP_DIR = join('..', 'surahs')

function escapeTypst(s) {
  // Escape characters that have special meaning in Typst strings
  return s.replace(/\\/g, '\\\\').replace(/"/g, '\\"')
}

function stripHtml(s) {
  // Remove HTML tags (e.g. <sup>, footnotes)
  return s.replace(/<[^>]+>/g, '')
}

function generateVerse(verse) {
  const words = verse.words.filter(w => w.charTypeName === 'word')
  const endMark = verse.words.find(w => w.charTypeName === 'end')

  const arWords = words.map(w => w.codeV2)
  const v2Pages = words.map(w => w.v2Page)
  const translitWords = words.map(w => w.transliteration?.text || '')
  const zhTranslation = verse.translations?.find(t => t.resourceId === 56)?.text || ''

  // Append verse number marker
  if (endMark) {
    arWords.push(endMark.codeV2)
    v2Pages.push(endMark.v2Page)
    translitWords.push(endMark.translation?.text || `(${verse.verseNumber})`)
  }

  const fmt = arr => arr.map(s => `"${escapeTypst(s)}"`).join(', ')
  const fmtNums = arr => arr.join(', ')

  let lines = []
  lines.push(`#quran-verse(`)
  lines.push(`  (${fmtNums(v2Pages)}),`)
  lines.push(`  (${fmt(arWords)}),`)
  lines.push(`  (${fmt(translitWords)}),`)
  lines.push(`  ([${zhTranslation}]),`)
  lines.push(`)`)

  return lines.join('\n')
}

function generateChapter(chapter, locator) {
  const lines = []

  lines.push(`#import "../libquran.typ": *`)
  lines.push(``)
  lines.push(`#show: quran-page.with(title: "${chapter.nameSimple}", title-ar: "${chapter.nameArabic}", title-tl: "${chapter.nameSimple}", locator: "${locator}")`)
  lines.push(``)

  for (const verse of chapter.verses) {
    lines.push(generateVerse(verse))
    lines.push(``)
  }

  return lines.join('\n')
}

async function main() {
  await mkdir(TYP_DIR, { recursive: true })

  const files = (await readdir(OUTPUT_DIR)).filter(f => f.endsWith('.json')).sort()

  for (const file of files) {
    const data = JSON.parse(await readFile(join(OUTPUT_DIR, file), 'utf-8'))
    const locator = file.replace('.json', '')
    const typContent = generateChapter(data, locator)
    const typName = file.replace('.json', '.typ')
    await writeFile(join(TYP_DIR, typName), typContent, 'utf-8')
    console.log(`Generated ${typName}`)
  }

  console.log(`Done. ${files.length} files generated.`)
}

main().catch(console.error)
