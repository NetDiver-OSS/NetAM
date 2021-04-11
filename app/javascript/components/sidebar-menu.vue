<script>
export default {
  props: {
    opened: {
      type: Boolean,
    },
    container_class: {
      type: String,
    }
  },
  data: function () {
    return {
      open: (this.props !== undefined) ? this.props.opened || false : false
    }
  },
  mounted() {
    this.toggleClassSlide()
  },
  methods: {
    toggleClassSlide() {
      let svg_expanded = this.$refs.button.querySelector('button > svg:nth-child(2)')
      if (this.open) {
        svg_expanded.classList.add('rotate-90')
      } else {
        svg_expanded.classList.remove('rotate-90')
      }
    },
    toggleMenu() {
      this.open = !this.open
      this.toggleClassSlide()
    }
  }
}
</script>

<template>
  <div :class="container_class">
    <div @click="toggleMenu" ref="button">
      <slot name="button" />
    </div>

    <div v-if="open" ref="menu">
      <slot  name="menu" />
    </div>
  </div>
</template>
