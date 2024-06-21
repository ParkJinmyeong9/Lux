<footer class="main-footer">
    <strong>Copyright &copy; 2014-2021 <a href="https://adminlte.io">AdminLTE.io</a>.</strong>
    All rights reserved.
    <div class="float-right d-none d-sm-inline-block">
      <b>Version</b> 3.2.0
    </div>
</footer>

<!-- Control Sidebar -->
<aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
</aside>
<!-- /.control-sidebar -->
</div>
<!-- ./wrapper -->

<!-- jQuery -->
<script src="plugins/jquery/jquery.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="plugins/jquery-ui/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button)
</script>
<!-- Bootstrap 4 -->
<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- ChartJS -->
<script src="plugins/chart.js/Chart.min.js"></script>
<!-- Sparkline -->
<script src="plugins/sparklines/sparkline.js"></script>
<!-- JQVMap -->
<script src="plugins/jqvmap/jquery.vmap.min.js"></script>
<script src="plugins/jqvmap/maps/jquery.vmap.usa.js"></script>
<!-- jQuery Knob Chart -->
<script src="plugins/jquery-knob/jquery.knob.min.js"></script>
<!-- daterangepicker -->
<script src="plugins/moment/moment.min.js"></script>
<script src="plugins/daterangepicker/daterangepicker.js"></script>
<!-- Tempusdominus Bootstrap 4 -->
<script src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
<!-- Summernote -->
<script src="plugins/summernote/summernote-bs4.min.js"></script>
<!-- overlayScrollbars -->
<script src="plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/adminlte.js"></script>

<script>
    $(document).ready(function () {
        // íì¬ íì´ì§ URLì ê°ì ¸ìµëë¤.
        var currentPageUrl = window.location.href;

        // íìì ë³´ ë©ë´ì íì í­ëª© ì¤ íì¬ íì´ì§ì ì¼ì¹íë í­ëª©ì ì°¾ìì íì±íí©ëë¤.
        $('.nav-treeview .nav-link').each(function () {
            // íì¬ íì´ì§ URLì´ í´ë¹ í­ëª©ì ë§í¬ URLê³¼ ì¼ì¹íëì§ íì¸í©ëë¤.
            if (currentPageUrl.includes($(this).attr('href'))) {
                // ì¼ì¹íë©´ í´ë¹ í­ëª©ì 'active' í´ëì¤ë¥¼ ì¶ê°í©ëë¤.
                $(this).addClass('active');
                // í´ë¹ í­ëª©ì´ ìí ìì í­ëª©ì¸ 'íìê´ë¦¬' ë©ë´ë íì±íí©ëë¤.
                $(this).closest('.nav-item.menu-close').addClass('menu-open').children('.nav-link').addClass('active');
            }
        });
    });
    
    $(document).ready(function() {
        // ì²´í¬ë°ì¤ë¥¼ í´ë¦­í  ë
        $('.row_checkbox').click(function() {
            var allChecked = true;
            $('.row_checkbox').each(function() {
                if (!$(this).prop('checked')) {
                    allChecked = false;
                    return false;
                }
            });
            $('#checkbox_test').prop('checked', allChecked);
        });

        // ì ì²´ ì í ì²´í¬ë°ì¤ë¥¼ í´ë¦­í  ë
        $('#checkbox_test').click(function() {
            $('.row_checkbox').prop('checked', $(this).prop('checked'));
        });
    });
</script>


</body>
</html>
