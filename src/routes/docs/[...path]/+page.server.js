import { error } from '@sveltejs/kit';
import fs from 'fs';
import path from 'path';

export async function load({ params }) {
  const docPath = params.path || 'index';
  const filePath = path.join(process.cwd(), 'src', 'docs', `${docPath}.md`);

  try {
    const content = await fs.promises.readFile(filePath, 'utf-8');
    return {
      content
    };
  } catch (err) {
    console.error('Error reading file:', err);
    throw error(404, 'Document not found');
  }
}