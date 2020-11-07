// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("@rails/activestorage").start()

import "bootstrap"

import '@fortawesome/fontawesome-free/js/all.min'
import 'admin-lte/dist/js/adminlte.min'
import 'admin-lte/plugins/chart.js/Chart.min'

import './dark_mode'
import './datatable'
import './select'

/* VueJS imports */
import Vue from 'vue/dist/vue.esm'
/* Components imports */
import request_ip from '../components/section/request_ip'

jQuery(document).ready(function() {
  $('#totp_to_valid').modal('show')
});

Vue.component('btn-request-ip', request_ip)

window.addEventListener('load', () => {
  new Vue({ el: '[data-behavior="vue"]' })
})
