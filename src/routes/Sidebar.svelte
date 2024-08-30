<script>
	import { page } from '$app/stores';
	import { Search, Home, Rocket, Download, Monitor, Book, Puzzle, Layout, Terminal, Calendar, User, Lock, Cog, PersonStanding, Code, Layers, Palette, Activity, Cpu, LifeBuoy, HelpCircle } from 'lucide-svelte';
  
	let searchTerm = '';
  
	const pages = [
    	{ name: 'Home', icon: Home, href: '/', section: 'Main' },
    	{ name: 'Getting Started', icon: Download, href: '/docs/8.7.3/ops/getting-started', section: 'Ops' },
    	{ name: 'Manual', icon: Book, href: '/docs/8.7.3/ops/manual', section: 'Ops' },
    	{ name: 'Architecture', icon: Layers, href: '/docs/8.7.3/ops/architecture', section: 'Ops' },
    	{ name: 'GitHub Auth', icon: Lock, href: '/docs/8.7.3/ops/github-auth', section: 'Ops' },
    	{ name: 'Plugins', icon: Puzzle, href: '/docs/8.7.3/ops/plugins', section: 'Ops' },
    	{ name: 'Agent', icon: PersonStanding, href: '/docs/8.7.3/dev/agent', section: 'Dev' },
    	{ name: 'API', icon: Code, href: '/docs/8.7.3/dev/api', section: 'Dev' },
    	{ name: 'Events', icon: Activity, href: '/docs/8.7.3/dev/events', section: 'Dev' },
    	{ name: 'Fabric', icon: Cpu, href: '/docs/8.7.3/dev/fabric', section: 'Dev' },
    	{ name: 'Hacking', icon: Terminal, href: '/docs/8.7.3/dev/hacking', section: 'Dev' },
    	{ name: 'Scheduling', icon: Calendar, href: '/docs/8.7.3/dev/scheduling', section: 'Dev' },
    	{ name: 'UI', icon: Layout, href: '/docs/8.7.3/dev/ui', section: 'Dev' },
    	{ name: 'Encryption', icon: Lock, href: '/docs/8.7.3/dev/design/encryption', section: 'Dev Design' },
    	{ name: 'Tenancy', icon: User, href: '/docs/8.7.3/dev/design/tenancy', section: 'Dev Design' },
    	{ name: 'WebUI', icon: Monitor, href: '/docs/8.7.3/dev/design/webui', section: 'Dev Design' },
	];
  
	$: filteredPages = pages.filter((page) =>
	  page.name.toLowerCase().includes(searchTerm.toLowerCase())
	);
  
	$: groupedPages = filteredPages.reduce((acc, page) => {
	  if (!acc[page.section]) acc[page.section] = [];
	  acc[page.section].push(page);
	  return acc;
	}, {});
  
	$: currentPath = $page.url.pathname;
  
	function isActive(href) {
	  return currentPath === href;
	}
  </script>
  
  <aside class="fixed inset-0 z-30 flex-none h-full w-64 lg:h-auto border-e border-gray-200 dark:border-gray-600 lg:overflow-y-visible lg:pt-20 lg:-mt-2 lg:block">
	<div class="overflow-y-auto px-4 pt-20 lg:pt-4 h-full bg-white scrolling-touch max-w-2xs lg:h-[calc(100vh-4.5rem)] lg:block dark:bg-gray-800 lg:me-0 lg:sticky top-2">
	  <div class="mb-4">
		<div class="relative">
		  <Search class="absolute left-3 top-1/2 h-5 w-5 -translate-y-1/2 transform text-gray-400" />
		  <input
			type="text"
			bind:value={searchTerm}
			placeholder="Search docs..."
			class="w-full pl-10 pr-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
		  />
		</div>
	  </div>
	  <nav>
		{#each Object.entries(groupedPages) as [section, sectionPages]}
		  <div class="mb-6">
			<p class="mb-2 text-sm uppercase text-gray-400 dark:text-gray-300">{section}</p>
			<ul>
			  {#each sectionPages as page}
				<li class="mb-1">
				  <a
					href={page.href}
					class="p-2 hover:bg-gray-100 text-gray-500 dark:hover:bg-gray-700 rounded-lg transition-colors duration-200 relative flex items-center flex-wrap font-medium {isActive(page.href)
					  ? 'cursor-default dark:text-primary-700'
					  : 'hover:text-gray-500 hover:cursor-pointer dark:text-gray-400 dark:hover:text-white'}"
				  >
					<svelte:component this={page.icon} class="w-5 h-5 mr-2" />
					{page.name}
				  </a>
				</li>
			  {/each}
			</ul>
		  </div>
		  {#if section !== 'Help'}
			<hr class="my-6" />
		  {/if}
		{/each}
	  </nav>
	</div>
  </aside>