// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")

require("bootstrap")

import '@fortawesome/fontawesome-free/js/all.min'
import 'admin-lte/dist/js/adminlte.min'
import 'admin-lte/plugins/chart.js/Chart.min'
import 'admin-lte/plugins/datatables/jquery.dataTables.min'
import 'admin-lte/plugins/datatables-bs4/js/dataTables.bootstrap4.min'
import 'admin-lte/plugins/select2/js/select2.full.min'

import './dark_mode'

$(".datatable").DataTable();
$('.select2').select2()
