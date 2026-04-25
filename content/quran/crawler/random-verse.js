import { readdir, readFile } from 'fs/promises'
import { existsSync } from 'fs'
import { join } from 'path'

const OUTPUT_DIR = 'output'
const ZH_RESOURCE_ID = 56 // Chinese (Ma Jian) used elsewhere in this repo

function printHelp() {
  console.log(`Usage: node random-verse.js [options]

Picks a random verse from crawler output JSON files.

Options:
  --seed <n>        Deterministic randomness (integer)
  --chapter <id>    Restrict to a single chapter id (1-114)
  --verse <n>       Restrict to verse number within chapter (1..versesCount)
  --json            Emit JSON instead of pretty text
  --check           Validate JSON has textUthmani + zh translation (56)
  -h, --help        Show this help
`)
}

function failMissingOutput() {
  console.error(`No crawler output found at "${OUTPUT_DIR}/".

This repo does not track generated JSON in git. To generate it:
  1) cd content/quran/crawler
  2) npm ci
  3) set QURAN_API_ID / QURAN_API_SECRET
  4) node chapters.js
  5) node crawl.js

Then re-run:
  node random-verse.js --seed 123
`)
  process.exit(1)
}

function mulberry32(seed) {
  let a = seed >>> 0
  return function next() {
    a |= 0
    a = (a + 0x6D2B79F5) | 0
    let t = Math.imul(a ^ (a >>> 15), 1 | a)
    t ^= t + Math.imul(t ^ (t >>> 7), 61 | t)
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296
  }
}

function parseArgs(argv) {
  const args = argv.slice(2)
  const out = {
    seed: null,
    chapter: null,
    verse: null,
    json: false,
    check: false,
    help: false,
  }

  for (let i = 0; i < args.length; i++) {
    const a = args[i]
    switch (a) {
      case '--seed':
        out.seed = Number.parseInt(args[++i], 10)
        if (!Number.isFinite(out.seed)) throw new Error(`Invalid --seed value`)
        break
      case '--chapter':
        out.chapter = Number.parseInt(args[++i], 10)
        if (!Number.isFinite(out.chapter)) throw new Error(`Invalid --chapter value`)
        break
      case '--verse':
        out.verse = Number.parseInt(args[++i], 10)
        if (!Number.isFinite(out.verse)) throw new Error(`Invalid --verse value`)
        break
      case '--json':
        out.json = true
        break
      case '--check':
        out.check = true
        break
      case '--help':
      case '-h':
        out.help = true
        break
      default:
        throw new Error(`Unknown argument: ${a}`)
    }
  }

  return out
}

function pickOne(rng, arr) {
  if (!arr.length) throw new Error('Cannot pick from empty array')
  const idx = Math.floor(rng() * arr.length)
  return arr[idx]
}

function getArabicText(verse) {
  const uthmani = typeof verse?.textUthmani === 'string' ? verse.textUthmani.trim() : ''
  if (uthmani) return { text: uthmani, field: 'textUthmani' }

  const imlaei = typeof verse?.textImlaei === 'string' ? verse.textImlaei.trim() : ''
  if (imlaei) return { text: imlaei, field: 'textImlaei' }

  return { text: '', field: null }
}

function getZhTranslation(verse) {
  const translations = Array.isArray(verse?.translations) ? verse.translations : []
  const t = translations.find(x => x && x.resourceId === ZH_RESOURCE_ID)
  const text = typeof t?.text === 'string' ? t.text.trim() : ''
  return text
}

async function main() {
  const opts = parseArgs(process.argv)
  if (opts.help) {
    printHelp()
    return
  }

  if (!existsSync(OUTPUT_DIR)) {
    failMissingOutput()
  }

  const allFiles = (await readdir(OUTPUT_DIR)).filter(f => f.endsWith('.json')).sort()
  if (allFiles.length === 0) {
    failMissingOutput()
  }

  const files = opts.chapter
    ? allFiles.filter(f => f.startsWith(String(opts.chapter).padStart(3, '0') + '-'))
    : allFiles

  if (files.length === 0) {
    console.error(`No chapter JSON files matched. (--chapter ${opts.chapter})`)
    process.exit(1)
  }

  if (opts.check) {
    let versesChecked = 0
    let missingUthmani = 0
    let missingZh56 = 0

    for (const file of files) {
      const chapter = JSON.parse(await readFile(join(OUTPUT_DIR, file), 'utf-8'))
      const verses = Array.isArray(chapter?.verses) ? chapter.verses : []
      for (const verse of verses) {
        versesChecked++
        if (!(typeof verse?.textUthmani === 'string' && verse.textUthmani.trim())) {
          missingUthmani++
        }
        if (!getZhTranslation(verse)) {
          missingZh56++
        }
      }
    }

    const okUthmani = missingUthmani === 0
    const okZh = missingZh56 === 0
    const summary = {
      filesChecked: files.length,
      versesChecked,
      requirements: {
        textUthmani: { ok: okUthmani, missing: missingUthmani },
        translation56: { ok: okZh, missing: missingZh56 },
      },
    }

    console.log(JSON.stringify(summary, null, 2))
    process.exit(okUthmani && okZh ? 0 : 2)
  }

  const seed = opts.seed ?? (Date.now() & 0xffffffff)
  const rng = mulberry32(seed)

  const file = pickOne(rng, files)
  const locator = file.replace(/\.json$/i, '')
  const chapter = JSON.parse(await readFile(join(OUTPUT_DIR, file), 'utf-8'))
  const verses = Array.isArray(chapter?.verses) ? chapter.verses : []

  if (verses.length === 0) {
    console.error(`Chapter JSON had no verses: ${file}`)
    process.exit(1)
  }

  const verseNum = opts.verse
    ? opts.verse
    : Math.floor(rng() * verses.length) + 1

  if (verseNum < 1 || verseNum > verses.length) {
    console.error(`--verse out of range. Got ${verseNum}, expected 1..${verses.length}`)
    process.exit(1)
  }

  const verse = verses[verseNum - 1]
  const arabic = getArabicText(verse)
  const zh = getZhTranslation(verse)

  const chapterId = chapter?.id ?? opts.chapter ?? null
  const verseKey =
    typeof verse?.verseKey === 'string'
      ? verse.verseKey
      : (Number.isFinite(chapterId) ? `${chapterId}:${verseNum}` : null)

  const payload = {
    seed,
    source: { file, locator },
    chapter: {
      id: chapter?.id ?? null,
      nameSimple: chapter?.nameSimple ?? null,
      nameArabic: chapter?.nameArabic ?? null,
      versesCount: chapter?.versesCount ?? null,
      revelationPlace: chapter?.revelationPlace ?? null,
    },
    verse: {
      verseNum,
      verseKey,
      arabic: arabic.text || null,
      arabicField: arabic.field,
      zh: zh || null,
      hasTranslations: Array.isArray(verse?.translations),
    },
  }

  if (!payload.verse.arabic) {
    console.error(
      `Verse is missing Arabic text. Expected "textUthmani" (preferred) or "textImlaei".\n` +
        `If you generated JSON with older settings, re-run crawl after enabling textUthmani in crawl.js.`
    )
    process.exit(1)
  }

  if (opts.json) {
    console.log(JSON.stringify(payload, null, 2))
    return
  }

  const headerParts = []
  if (payload.chapter.id) headerParts.push(`Surah ${payload.chapter.id}`)
  if (payload.chapter.nameSimple) headerParts.push(payload.chapter.nameSimple)
  if (payload.chapter.nameArabic) headerParts.push(payload.chapter.nameArabic)
  const header = headerParts.join(' — ')

  console.log(header)
  console.log(`${payload.verse.verseKey ?? `Verse ${payload.verse.verseNum}`}  (seed=${seed})`)
  console.log(`source: ${OUTPUT_DIR}/${file}`)
  console.log('')
  console.log(payload.verse.arabic)
  if (payload.verse.zh) {
    console.log('')
    console.log(payload.verse.zh)
  }
}

main().catch(err => {
  console.error(err?.stack || String(err))
  process.exit(1)
})
