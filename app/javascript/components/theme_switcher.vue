<script>
import Cookies from 'js-cookie';

export default {
  data: function() {
    return {
      theme: Cookies.get('theme') || 'light'
    }
  },
  methods: {
    switchTheme () {
      if (this.theme === 'light') {
        this.setTheme('dark')
        document.getElementsByTagName('html')[0].classList.add('dark')
      } else {
        this.setTheme('light')
        document.getElementsByTagName('html')[0].classList.remove('dark')
      }
    },
    setTheme (targetTheme) {
      this.theme = targetTheme
      Cookies.set('theme', targetTheme, {expires: 365 * 10});
    }
  }
}
</script>

<template>
  <button @click="switchTheme()" class="bg-gray-800 p-1 rounded-full text-gray-400 hover:text-white focus:outline-none">
    <span class="sr-only">Switch theme</span>

    <svg v-if="theme === 'light'" class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z" />
    </svg>

    <svg v-if="theme === 'dark'" class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z" />
    </svg>
  </button>
</template>
