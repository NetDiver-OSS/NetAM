<script>
export default {
  props: {
    title: {
      type: String,
      required: true
    }
  },
  data: function () {
    return {
      open: false
    }
  },
  methods: {
    toggleClassSlide() {
      this.$refs.slide_background.classList.toggle('opacity-0')
      this.$refs.slide_background.classList.toggle('opacity-100')
      this.$refs.slide_menu.classList.toggle('translate-x-0')
      this.$refs.slide_menu.classList.toggle('-translate-x-full')
    },
    toggleSlide() {
      if (this.open) {
        this.toggleClassSlide()
        setTimeout(() => {
          this.open = !this.open
        }, 500)
      } else {
        this.open = !this.open
        setTimeout(() => {
          this.toggleClassSlide()
        }, 200)
      }
    }
  }
}
</script>

<template>
  <div>
    <div v-if="open" class="fixed z-50 inset-0 overflow-hidden">
      <div class="absolute inset-0 overflow-hidden">
        <div class="absolute inset-0 bg-black bg-opacity-75 transition-opacity ease-in-out duration-200 opacity-0" ref="slide_background" aria-hidden="true" @click="toggleSlide"></div>
        <section class="absolute inset-y-0 left-0 max-w-full flex" aria-labelledby="slide-over-heading">
          <div class="relative w-screen max-w-md transform transition ease-in-out duration-700 -translate-x-full" ref="slide_menu">
            <div class="h-full flex flex-col py-6 bg-white dark:bg-gray-700 shadow-xl overflow-y-scroll">
              <div class="flex flex-row justify-between px-4 sm:px-6">
                <h2 id="slide-over-heading" class="text-lg font-medium text-gray-900 dark:text-gray-100">{{ title }}</h2>
                <button class="rounded-md text-gray-300 hover:text-black focus:outline-none focus:ring-2 focus:ring-black" @click="toggleSlide">
                  <span class="sr-only">Close panel</span>
                  <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                  </svg>
                </button>
              </div>
              <div class="mt-6 relative flex-1 px-4 sm:px-6">
                <slot name="content" />
              </div>
            </div>
          </div>
        </section>
      </div>
    </div>
    <div @click="toggleSlide">
      <slot name="button" />
    </div>
  </div>
</template>
