document.querySelectorAll('.modal').forEach(function (el) {
  return new bootstrap.Modal(el, {}).show()
})

document.querySelectorAll('.toast').forEach(function (el) {
  return new bootstrap.Toast(el, {autohide: false}).show()
})
