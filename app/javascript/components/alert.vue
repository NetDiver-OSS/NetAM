<script>
export default {
  props: {
    message: {
      type: String,
      required: true
    },
    color: {
      type: String,
      default: 'green'
    }
  },
  computed: {
    containerClass () {
      return `bg-${this.color}-600`
    }
  },
  mounted() {
    setTimeout(() => {
      this.$el.classList.toggle('translate-y-0')
      this.$el.classList.toggle('-translate-y-full')
    }, 200)
    setTimeout(() => {
      this.$el.classList.toggle('translate-y-0')
      this.$el.classList.toggle('-translate-y-full')
    }, 4800)
    setTimeout(() => {
      this.$destroy()
      this.$el.parentNode.removeChild(this.$el)
    }, 5000)
  }
}
</script>

<template>
  <div class="absolute z-30 top-20 md:top-0 left-0 md:left-1/4 w-full md:w-1/2 mt-1.5 rounded-md transition ease-in-out duration-200 transform -translate-y-full" :class="containerClass">
    <div class="mx-auto p-2 sm:px-6 lg:px-8">
      <div class="flex items-center flex-col">
        <p class="font-bold text-white">{{ message }}</p>
      </div>
    </div>
  </div>
</template>
