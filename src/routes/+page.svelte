<script>
	import Sidebar from './Sidebar.svelte';
  </script>
  
  <div class="flex">
	<Sidebar />
	<main class="flex-1 p-10 text-white">

			<meta charset="UTF-8">
			<meta name="viewport" content="width=device-width, initial-scale=1.0">
			<title>SHIELD Documentation</title>
			<script src="https://cdn.tailwindcss.com"></script>
			<style>
				body {
					font-family: Arial, sans-serif;
				}
			</style>

			<div class="container mx-auto px-4 py-8 max-w-4xl">
				<h1 class="text-4xl font-bold mb-6 text-white">Writing SHIELD Documentation</h1>
				
				<p class="mb-4">This super-meta document explains how to write and review the documentation in the SHIELD codebase.</p>
				
				<p class="mb-4">Documentation is stored in the <code class="bg-gray-800 px-1 rounded">docs/</code> directory. There are two main sub-categories: Operator documentation in <code class="bg-gray-800 px-1 rounded">docs/ops</code> and Developer documentation in <code class="bg-gray-800 px-1 rounded">docs/dev</code>.</p>
				
				<p class="mb-4">Every document / guide / write-up exists as a markdown file in its sub-category directory, and a directory to contain images for that document. For example, assume we want to write a new operator document, called <em>How To Install SHIELD on a Raspberry Pi</em>. We might start with the following:</p>
				
				<pre class="bg-gray-800 p-4 rounded mb-4 overflow-x-auto">
		$ mkdir docs/ops/install-on-raspberry-pi
		$ vim   docs/ops/install-on-raspberry-pi.md</pre>
				
				<p class="mb-4">For the markdown document, write it as though it is the only set of headers; start with an h1, and follow outline format from there.</p>
				
				<h2 class="text-2xl font-bold mt-8 mb-4 text-white">The Documentum Instance</h2>
				
				<p class="mb-4">To ensure that screenshots of SHIELD are uniform, we supply a docker-compose recipe that spins up a fixed configuration of SHIELD. It can be found in <code class="bg-gray-800 px-1 rounded">docs/docker-compose.yml</code>, and you run it like this:</p>
				
				<pre class="bg-gray-800 p-4 rounded mb-4 overflow-x-auto">
		$ docker-compose -f docs/docker-compose up</pre>
				
				<p class="mb-4">Then, you can access the SHIELD instance at <a href="http://localhost:9009" class="text-blue-400 hover:underline">http://localhost:9009</a>. You can log into it with the username <code class="bg-gray-800 px-1 rounded">admin</code>, and the password <code class="bg-gray-800 px-1 rounded">password</code>, and may want to import the documentation data set:</p>
				
				<pre class="bg-gray-800 p-4 rounded mb-4 overflow-x-auto">
		$ ./shield api http://localhost:9009 documentum
		$ ./shield -c documentum login
		$ ./shield -c documentum import docs/import.yml</pre>
				
				<h2 class="text-2xl font-bold mt-8 mb-4 text-white">Hyperlink References</h2>
				
				<p class="mb-4">Because we intend to generate copies of the documentation, and store them on a per-version basis, we need the documentation to be relocatable. Whenever you make references to other assets (images, PDFs, other parts of the documentation), use the special path <code class="bg-gray-800 px-1 rounded">/docs/8.7.3/</code> as a stand-in for the <em>root of the <code class="bg-gray-800 px-1 rounded">docs/</code> directory</em>. When referencing the SHIELD codebase, the special path <code class="bg-gray-800 px-1 rounded">https://github.com/starkandwayne/shield/tree/v8.7.3/</code> can be used. For example, to link to the <code class="bg-gray-800 px-1 rounded">core/main.go</code> file, use the path <code class="bg-gray-800 px-1 rounded">https://github.com/starkandwayne/shield/tree/v8.7.3/core/main.go</code>.</p>
				
				<h2 class="text-2xl font-bold mt-8 mb-4 text-white">Generating the Documentation</h2>
				
				<p class="mb-4">To review the documentation for formatting and readability, you will need to run the generation process. This process creates an embeddedable, relocated copy of the documentation in a new output directory, while properly resolving the <code class="bg-gray-800 px-1 rounded">/docs/8.7.3/</code> and <code class="bg-gray-800 px-1 rounded">https://github.com/starkandwayne/shield/tree/v8.7.3/</code> placeholders to their appropriate values.</p>
				
				<p class="mb-4">The process is all wrapped up in the <code class="bg-gray-800 px-1 rounded">bin/mkdocs</code> script. You can run it like this:</p>
				
				<pre class="bg-gray-800 p-4 rounded mb-4 overflow-x-auto">
		$ ./bin/mkdocs --version v8.1.x \
					   --output  tmp/docs \
					   --docroot file://$PWD/tmp/docs \
					   --style   basic</pre>
				
				<p class="mb-4">This should copy a bunch of files into a new <code class="bg-gray-800 px-1 rounded">tmp/docs</code> directory in the current working directory. To visit the site in your browser:</p>
				
				<pre class="bg-gray-800 p-4 rounded mb-4 overflow-x-auto">
		$ open file://$PWD/tmp/docs</pre>
				
				<p class="mb-4">The <em>basic</em> style provides enough boilerplate style and javascript code to make the docs readable. Namely, it provides a dynamically generated sidebar for navigation, including all h2 and h3 headings.</p>
			</div>

	</main>
  </div>a