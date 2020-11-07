<script>
import * as axios from "axios";
import Cookies from 'js-cookie';
import { Fragment } from 'vue-fragment'

const AXIOS_HEADERS = {
  headers: {
    'Authorization': 'Bearer ' + Cookies.get('token')
  }
}

export default {
  name: "request_ip",
  components: { Fragment },
  props: {
    section_id: {
      required: true,
      type: Number
    }
  },
  data: function () {
    return {
      loading: false,
      error: false,
      message: ''
    }
  },
  methods: {
    requestIP(e) {
      e.preventDefault()

      this.loading = true

      axios.post('/api/v1/sections/' + this.section_id + '/request_ip', {}, AXIOS_HEADERS)
        .then((response) => {
          this.message = response.data
        })
        .catch((error) => {
          this.error = true
          this.message = error
        })
        .finally(() => {
          this.loading = false
          $('.modal').modal('show')
        })
    }
  },
  computed: {
    btnClass() {
      return this.error ? 'btn-danger' : 'btn-secondary'
    },
    usageEditURL() {
      return '/sections/' + this.section_id + '/usages/' + this.message.id + '/edit'
    },
    darkModeClass() {
      return Cookies.get('dark_mode') === "true" ? "bg-dark text-white" : ""
    }
  }
}
</script>

<template>
  <fragment>
    <button v-if="!loading" class="btn btn-flat" :class="btnClass" @click="requestIP">
      <i class="fas fa-ethernet"></i> Get unused IP
    </button>

    <button v-if="loading" class="btn btn-flat" :class="btnClass" disabled>
      <span class="spinner-grow spinner-grow-sm" role="status" aria-hidden="true"></span>
      Loading...
    </button>

    <div class="modal" tabindex="-1">
      <div class="modal-dialog">
        <div class="modal-content" :class="darkModeClass">
          <div class="modal-header">
            <h5 class="modal-title">IP address Request</h5>
          </div>
          <div class="modal-body">
            <p v-if="!error">Your address IP is: <b>{{ this.message.ip_used }}</b></p>
            <p v-else>{{ this.message }}</p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            <a class="btn btn-primary" :href="usageEditURL">Edit Address details</a>
          </div>
        </div>
      </div>
    </div>
  </fragment>
</template>
