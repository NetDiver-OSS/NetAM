// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

require("bootstrap")

import '@fortawesome/fontawesome-free/js/all.min'
import 'admin-lte/dist/js/adminlte.min'
import 'admin-lte/plugins/chart.js/Chart.min'
import 'admin-lte/plugins/datatables/jquery.dataTables.min'
import 'admin-lte/plugins/datatables-bs4/js/dataTables.bootstrap4.min'
import 'admin-lte/plugins/select2/js/select2.full.min'



$(".datatable").DataTable();
$('.select2').select2()


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
// Support component names relative to this directory:
var componentRequireContext = require.context("components", true);
var ReactRailsUJS = require("react_ujs");
ReactRailsUJS.useContext(componentRequireContext);
