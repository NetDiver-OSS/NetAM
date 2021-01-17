// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("@rails/activestorage").start()

import 'stylesheets/application'

import '@fortawesome/fontawesome-free/js/all.min'

// import './datatable'
// import './select'

/* VueJS imports */
import Vue from 'vue/dist/vue.esm'
/* Components imports */
import request_ip from '../components/section/request_ip'
import theme_switcher from '../components/theme_switcher'
import slide_menu from "../components/slide_menu";
import dropdown from '../components/dropdown'
import alert from "../components/alert";
import section__pie_usage from "../components/section/pie_usage";
import section__status_scan from "../components/section/status_scan";


Vue.component('btn-request-ip', request_ip)
Vue.component('theme-switcher', theme_switcher)
Vue.component('dropdown', dropdown)
Vue.component('slide-menu', slide_menu)
Vue.component('alert', alert)
Vue.component('section-usage', section__pie_usage)
Vue.component('section-scan', section__status_scan)

window.addEventListener('load', () => {
  new Vue({ el: '[data-behavior="vue"]' })
})
