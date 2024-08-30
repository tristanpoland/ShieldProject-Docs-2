<script>
	import '../app.pcss';
	import Footer from './Footer.svelte';
	import Navbar from './Navbar.svelte';
	import Sidebar from './Sidebar.svelte';
</script>

<header
	class="sticky top-0 z-40 mx-auto w-full flex-none border-b border-gray-200 bg-white dark:border-gray-600 dark:bg-gray-800"
>
	<Navbar />
</header>

<style>
  #myVideo {
    position: fixed;
    right: 0;
    bottom: 0;
    top: 0;
    left: 0;
    min-width: 100%;
    min-height: 100%;
  }

</style>



<div class="overflow-hidden lg:flex">
	<Sidebar />
	<div class="relative h-full w-full overflow-y-auto lg:ml-64">
		<slot />
    <Footer />
	</div>
</div>
