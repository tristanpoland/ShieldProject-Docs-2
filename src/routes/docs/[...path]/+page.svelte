<script>
  import { onMount } from 'svelte';
  import { marked } from 'marked';
  import { markedHighlight } from "marked-highlight";
  import hljs from 'highlight.js';
  import 'highlight.js/styles/github.css';
  import Sidebar from '../../Sidebar.svelte';
  import '$lib/styles/markdown.css';

  export let data;

  let content = '';
  let toc = [];

  // Set up marked with GitHub Flavored Markdown
  marked.use({
    gfm: true,
    breaks: true,
  });

  // Set up syntax highlighting
  marked.use(markedHighlight({
    langPrefix: 'hljs language-',
    highlight(code, lang) {
      const language = hljs.getLanguage(lang) ? lang : 'plaintext';
      return hljs.highlight(code, { language }).value;
    }
  }));

  function slugify(text) {
    return text.toString().toLowerCase()
      .replace(/\s+/g, '-')           // Replace spaces with -
      .replace(/[^\w\-]+/g, '')       // Remove all non-word chars
      .replace(/\-\-+/g, '-')         // Replace multiple - with single -
      .replace(/^-+/, '')             // Trim - from start of text
      .replace(/-+$/, '');            // Trim - from end of text
  }

  function generateTocAndAddIds(tokens) {
    const headings = [];
    tokens.forEach(token => {
      if (token.type === 'heading') {
        const id = slugify(token.text);
        token.id = id;
        headings.push({
          id: id,
          text: token.text,
          level: token.depth
        });
      }
    });
    return headings;
  }

  function addIdsToHeadings(html, toc) {
    toc.forEach(item => {
      const regex = new RegExp(`<h${item.level}>(${item.text})<\/h${item.level}>`, 'g');
      html = html.replace(regex, `<h${item.level} id="${item.id}">${item.text}</h${item.level}>`);
    });
    return html;
  }

  $: {
    if (data.content) {
      const tokens = marked.lexer(data.content);
      toc = generateTocAndAddIds(tokens);
      let rawHtml = marked.parser(tokens);
      content = addIdsToHeadings(rawHtml, toc);
    }
  }

  onMount(() => {
    const tocElement = document.getElementById('table-of-contents');
    if (tocElement) {
      tocElement.addEventListener('click', (e) => {
        if (e.target.tagName === 'A') {
          e.preventDefault();
          const targetId = e.target.getAttribute('href').slice(1);
          const targetElement = document.getElementById(targetId);
          if (targetElement) {
            targetElement.scrollIntoView({ behavior: 'smooth' });
          }
        }
      });
    }
  });
</script>

<div class="flex bg-gray-900 text-gray-300">
  <Sidebar />
  <div class="flex-1 p-10 flex">
    <nav id="table-of-contents" class="w-64 pr-8">
      <h2 class="text-xl font-bold mb-4 text-white">Table of Contents</h2>
      <ul class="space-y-2">
        {#each toc as item}
          <li style="margin-left: {(item.level - 1) * 1}rem">
            <a href="#{item.id}" class="text-blue-400 hover:underline">{item.text}</a>
          </li>
        {/each}
      </ul>
    </nav>
    <main class="flex-1">
      <div class="markdown-body" style="max-width: 800px;">
        {@html content}
      </div>
    </main>
  </div>
</div>

<style>
  :global(body) {
    background-color: #1a202c;
    color: #e2e8f0;
  }
  
  :global(.markdown-body) {
    color: #e2e8f0;
    background-color: transparent;
  }

  :global(.markdown-body h1),
  :global(.markdown-body h2),
  :global(.markdown-body h3),
  :global(.markdown-body h4),
  :global(.markdown-body h5),
  :global(.markdown-body h6) {
    color: #fff;
  }

  #table-of-contents {
    position: sticky;
    top: 2rem;
    max-height: calc(100vh - 4rem);
    overflow-y: auto;
  }
</style>
