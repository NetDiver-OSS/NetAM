<script>
import iconsBrands from '@fortawesome/fontawesome-free/sprites/brands.svg'
import iconsSolid from '@fortawesome/fontawesome-free/sprites/solid.svg'
import iconsRegular from '@fortawesome/fontawesome-free/sprites/regular.svg'

export default {
  name: "fa-icon",
  props: {
    name: {
      type: String,
      required: true
    },
    type: {
      type: String,
      required: true
    },
    className: {
      type: String,
      default: ''
    },
    size: {
      type: String,
      default: 16
    }
  },
  components: {
    iconsBrands,
    iconsSolid,
    iconsRegular
  },
  computed: {
    spritePath() {
      switch (this.type) {
        case 'brands':
          return iconsBrands + '#' + this.name
        case 'solid':
          return iconsSolid + '#' + this.name
        case 'regular':
          return iconsRegular + '#' + this.name
      }
    }
  }
}
</script>

<template>
  <svg :width="size" :height="size" fill="currentColor" :class="className">
    <use :xlink:href="spritePath"/>
  </svg>
</template>
