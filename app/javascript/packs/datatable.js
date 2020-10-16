import 'admin-lte/plugins/datatables/jquery.dataTables.min'
import 'admin-lte/plugins/datatables-bs4/js/dataTables.bootstrap4.min'

const USAGE_TYPE = [
  "Locked", "Actived",
  "Down", "Dhcp"
]

jQuery(document).ready(function() {
  $('.datatable').DataTable({
    "ordering": false
  })

  $('#address-table>table').DataTable({
    "ordering": false,
    initComplete: function () {
      this.api().column(3).every( function () {
        var column = this;
        var select = $('<select class="form-control form-control-sm"><option value="">All states</option></select>')
          .appendTo( $(column.header()).empty() )
          .on( 'change', function () {
            var val = $.fn.dataTable.util.escapeRegex(
              $(this).val()
            );

            column
              .search( val ? val : '', true, false )
              .draw();
          } );

        $.each(USAGE_TYPE, function( index, value ) {
            select.append( '<option value="'+value+'">'+value+'</option>' )
          } );
      } );
    }
  })
});
