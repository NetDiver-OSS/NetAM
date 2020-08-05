import 'admin-lte/plugins/select2/js/select2.full.min'

jQuery(document).ready(function() {
  $('.select2').select2()

  $('.custom-file-input').change(function(e) {
    $('.custom-file-label')[0].textContent = $('.custom-file-input')[0].value
  })
});
