<script>
	import { DarkMode, NavBrand, NavHamburger, Navbar, Search, ToolbarButton } from 'flowbite-svelte';
	import '../app.pcss';

	export let fluid = true;
</script>

<Navbar {fluid} color="default">
	<div class="flex w-fit items-center justify-start">
		<NavHamburger />
		<NavBrand href="https://horizon.farbeyond.dev" class="flex items-center ms-2 md:me-24">
			<img
				src="https://github.com/shieldproject/website/blob/master/content/brand/4x/shield-l1ns@4x.png?raw=true"
				class="me-3 h-6 sm:h-8"
				alt="Horizon Logo"
			/>
			<span class="self-center whitespace-nowrap text-xl font-semibold dark:text-white sm:text-2xl ms-2">
				Shield Data Protection
			</span>

		</NavBrand>
		<div class="w-96">
		</div>
	</div>

	<div class="ms-auto flex items-center gap-2 p-1 invisible">
		<DarkMode />
	</div>
</Navbar>
