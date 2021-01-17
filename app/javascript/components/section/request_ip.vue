<script>
import * as axios from "axios";
import Cookies from 'js-cookie';
import { Fragment } from 'vue-fragment'
import Modal from "../modal";

const AXIOS_HEADERS = {
  headers: {
    'Authorization': 'Bearer ' + Cookies.get('token')
  }
}

export default {
  name: "request_ip",
  components: {Modal, Fragment },
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
      this.loading = true
      this.error = false
      this.message = ''

      axios.post('/api/v1/sections/' + this.section_id + '/request_ip', {}, AXIOS_HEADERS)
        .then((response) => {
          this.message = response.data
        })
        .catch((error) => {
          this.error = true
          this.message = error.response.data.error
        })
        .finally(() => {
          this.loading = false
        })
    }
  },
  computed: {
    usageEditURL() {
      return '/sections/' + this.section_id + '/usages/' + this.message.id + '/edit'
    },
    fields() {
      return {
        edit_address_details: __('Edit Address details'),
        get_unused_ip: __('Get unused IP'),
        ip_address_request: __('IP address Request'),
        ip_display_message: __('Your address IP is'),
        loading: __('Loading')
      }
    }
  }
}
</script>

<template>
  <fragment>
    <a class="btn cursor-pointer mr-1" v-if="!loading" @click.prevent="requestIP">
      <i class="fas fa-ethernet"></i> {{ fields.get_unused_ip }}
    </a>

    <a class="btn cursor-pointer mr-1" v-if="loading" disabled>
      {{ fields.loading }}...
    </a>

    <modal v-if="message !== '' && !error" :title="fields.ip_address_request" :message="fields.ip_display_message + ' : ' + this.message.ip_used">
      <template v-slot:button >
        <a :href="usageEditURL" class="w-full inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 bg-blue-600 text-base font-medium text-white hover:bg-blue-700 focus:outline-none sm:ml-3 sm:w-auto sm:text-sm">
          {{ fields.edit_address_details }}
        </a>
      </template>
    </modal>

    <modal v-if="message !== '' && error" :title="fields.ip_address_request" :message="this.message" />
  </fragment>
</template>
