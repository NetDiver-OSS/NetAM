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
      state: undefined,
      oldSate: undefined
    }
  },
  methods: {
    fetchData() {
      axios.get('/admin/api/status/' + this.jid)
        .then((response) => {
          this.state = response.data
        })

      if (this.state === 'complete' || this.state == null) {
        clearInterval(this.$timer)
      }

      if (this.oldSate === 'working' && this.state === 'complete') {
        document.location.reload()
      }

      this.oldSate = this.state
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
    <callout v-if="state === 'queued'" :message="fields.queued" color="red" />
    <callout v-if="state === 'working'" :message="fields.working" color="yellow" />
    <callout v-if="state === 'complete'" :message="fields.complete" color="green" />
  </div>
</template>
