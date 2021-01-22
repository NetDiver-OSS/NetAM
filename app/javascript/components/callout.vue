<script>
export default {
  props: {
    message: {
      type: String,
      required: true
    },
    color: {
      type: String,
      default: 'gray'
    }
  },
  computed: {
    borderColor() {
      return `border-${this.color}-400`
    }
  }
}
</script>

<template>
  <div class="bg-white dark:bg-gray-600 border-l-8 rounded shadow p-5 my-3" :class="borderColor">
    <p class="font-bold text-black dark:text-white">{{ message }}</p>
  </div>
</template>
