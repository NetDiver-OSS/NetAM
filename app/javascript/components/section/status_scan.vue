<script>
import * as axios from "axios";
import Callout from "../callout";

export default {
  components: {Callout},
  props: {
    jid: {
      required: true,
      type: String
    }
  },
  data: function () {
    return {
      message: undefined
    }
  },
  methods: {
    fetchData() {
      axios.get('/admin/api/status/' + this.jid)
        .then((response) => {
          this.message = response.data
        })

      if (this.message === 'complete' || this.message == null) {
        clearInterval(this.$timer)
      }
    }
  },
  mounted() {
    this.fetchData()

    this.$timer = setInterval(() => {
      this.fetchData()
    }, 2000)
  },
  destroyed() {
    clearInterval(this.$timer)
  },
  computed: {
    fields() {
      return {
        queued: __('Scan Queued'),
        working: __('Scan in progress'),
        complete: __('Scan complete')
      }
    }
  }
}
</script>

<template>
  <div>
    <callout v-if="message === 'queued'" :message="fields.queued" color="red" />
    <callout v-if="message === 'working'" :message="fields.working" color="yellow" />
    <callout v-if="message === 'complete'" :message="fields.complete" color="green" />
  </div>
</template>
