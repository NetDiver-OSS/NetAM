<script>
import { isValidCron } from 'cron-validator'

export default {
  mounted() {
    const input = this.$refs.input.childNodes[0]

    input.addEventListener('keyup', () => {
      if (isValidCron(input.value)) {
        input.classList.remove('invalid')
      } else {
        input.classList.add('invalid')
      }
    })
  }
}
</script>

<template>
  <div ref="input">
    <slot></slot>
  </div>
</template>
