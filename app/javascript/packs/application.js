// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("@rails/activestorage").start()
require("turbolinks").start()
require("channels")

import "bootstrap"

import '@fortawesome/fontawesome-free/js/all.min'
import 'admin-lte/dist/js/adminlte.min'
import 'admin-lte/plugins/chart.js/Chart.min'

import './dark_mode'
import './datatable'
import './select'

jQuery(document).ready(function() {
  $('#totp_to_valid').modal('show')
});
