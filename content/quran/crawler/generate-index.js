import { readFile, writeFile, readdir } from 'fs/promises'
import { join } from 'path'

const OUTPUT_DIR = 'output'
const INDEX_PATH = join('..', 'index.typ')

async function main() {
  const files = (await readdir(OUTPUT_DIR)).filter(f => f.endsWith('.json')).sort()

  const chapters = []
  for (const file of files) {
    const data = JSON.parse(await readFile(join(OUTPUT_DIR, file), 'utf-8'))
    const locator = file.replace('.json', '')
    chapters.push({ ...data, locator })
  }

  // generate TOC
  const lines = []
  lines.push("#outline()")

  // Include all surah files
  for (const ch of chapters) {
    lines.push(`#include "./surahs/${ch.locator}.typ"`)
  }
  lines.push(``)

  await writeFile(INDEX_PATH, lines.join('\n'), 'utf-8')
  console.log(`Generated index.typ with ${chapters.length} chapters.`)
}

main().catch(console.error)
