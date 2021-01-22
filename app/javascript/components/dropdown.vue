<script>
export default {
  props: {
    container_class: {
      type: String,
    }
  },
  data: function () {
    return {
      open: false
    }
  },
  methods: {
    toggleClassSlide() {
      this.$refs.menu.classList.toggle('opacity-0')
      this.$refs.menu.classList.toggle('scale-95')
      this.$refs.menu.classList.toggle('opacity-100')
      this.$refs.menu.classList.toggle('scale-100')
    },
    toggleMenu() {
      if (this.open) {
        this.toggleClassSlide()
        setTimeout(() => {
          this.open = !this.open
        }, 200)
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
  <div :class="container_class">
    <div @click="toggleMenu">
      <slot name="button" />
    </div>

    <div v-if="open" ref="menu" class="transition ease-in-out duration-100 transform opacity-0 scale-95">
      <slot  name="menu" />
    </div>
  </div>
</template>
