import { QuranClient, Language } from '@quranjs/api'
import { writeFile } from 'fs/promises'

const CLIENT_ID = process.env.QURAN_API_ID
const CLIENT_SECRET = process.env.QURAN_API_SECRET

const client = new QuranClient({
    clientId: CLIENT_ID,
    clientSecret: CLIENT_SECRET,
})

const chapters = await client.chapters.findAll()
await writeFile('chapters.json', JSON.stringify(chapters, null, 2))
