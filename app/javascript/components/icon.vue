<script>
export default {
  name: "icon",
  props: {
    name: {
      type: String,
      required: true
    },
    size: {
      type: String,
      default: 16
    }
  },
  computed: {
    manifest() {
      const manifestFile = require("../../../public/packs/manifest.json")
      return {
        "media/bootstrap-icons/bootstrap-icons.svg": manifestFile["media/bootstrap-icons/bootstrap-icons.svg"]
      }
    },
    spritePath() {
      console.log(this.manifest)
      return this.manifest['media/bootstrap-icons/bootstrap-icons.svg'] + '#' + this.name
    }
  }
}
</script>

<template>
  <svg :width="size" :height="size" fill="currentColor">
    <use :xlink:href="spritePath"/>
  </svg>
</template>
