$(document).ready(function () {
  $('.ip_usage').progress({
    className: {
      error: 'success',
      success: 'error',
      active: 'error'
    }
  });
  $('.ui.dropdown').dropdown();
  $('.popupdisplay').popup();
});
