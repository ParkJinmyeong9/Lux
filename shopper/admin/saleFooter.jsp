<%@page import="shopper.admin.PaymentsMgr"%>
<footer class="main-footer">
    <strong>Copyright &copy; 2014-2021 <a href="https://adminlte.io">AdminLTE.io</a>.</strong>
    All rights reserved.
    <div class="float-right d-none d-sm-inline-block">
      <b>Version</b> 3.2.0
    </div>
</footer>

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Add Content Here -->
  </aside>
  <!-- /.control-sidebar -->
</div>
<!-- ./wrapper -->

<!-- jQuery -->
<script src="plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- ChartJS -->
<script src="plugins/chart.js/Chart.min.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/adminlte.min.js"></script>

<%
    PaymentsMgr paymentsMgr = new PaymentsMgr();
    String paymentsData = paymentsMgr.sumAmount();
    String yearData = paymentsMgr.sumYearAmount();
    String lastYearData = paymentsMgr.sumLastYearAmount();
%>
<!-- Page specific script -->
<script>
  $(function () {
    /* ChartJS
     * -------
     * Here we will create a few charts using ChartJS
     */

    //-------------
    //- PIE CHART -
    //-------------
    // Get context with jQuery - using jQuery's .get() method.
    
     // JSON 데이터 파싱
    var payments = JSON.parse('<%= paymentsData %>');

    var labels = [];
    var data = [];

    for (var i = 0; i < payments.length; i++) {
        labels.push(payments[i].paymentMethod);
        data.push(payments[i].totalAmount);
    }

    var pieData = {
        labels: labels,
        datasets: [{
            data: data,
            backgroundColor: ['#f56954', '#00a65a', '#f39c12', '#00c0ef', '#3c8dbc', '#d2d6de', '#ff0000']
        }]
    };

    var pieChartCanvas = $('#pieChart').get(0).getContext('2d');
    var pieOptions = {
        maintainAspectRatio: false,
        responsive: true
    };
    new Chart(pieChartCanvas, {
        type: 'pie',
        data: pieData,
        options: pieOptions
    });

    //-------------
    //- BAR CHART -
    //-------------
    var barChartCanvas = $('#barChart').get(0).getContext('2d')
    
    var ypayments = JSON.parse('<%= yearData %>');
    var lypayments = JSON.parse('<%= lastYearData %>');

    var ydata = [];
    var ylabel = [];
    
    var lydata = [];
    var lylabel = []; 

    for (var i = 0; i < ypayments.length; i++) {
    	ydata.push(ypayments[i].totalFinalPrice);
    }
    
    for (var i = 0; i < lypayments.length; i++) {
    	lydata.push(lypayments[i].totalFinalPrice);
    }
    
	ylabel.push(ypayments[0].year);
	lylabel.push(lypayments[0].year);
    console.log(lydata);
	
    var barChartData = {
      labels  : ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
      datasets: [
        {
          label               : ylabel,
          backgroundColor     : 'rgba(60,141,188,0.9)',
          borderColor         : 'rgba(60,141,188,0.8)',
          pointRadius         : false,
          pointColor          : '#3b8bba',
          pointStrokeColor    : 'rgba(60,141,188,1)',
          pointHighlightFill  : '#fff',
          pointHighlightStroke: 'rgba(60,141,188,1)',
          data                : ydata
        },
        {
            label               : lylabel,
            backgroundColor     : 'rgba(210, 214, 222, 1)',
            borderColor         : 'rgba(210, 214, 222, 1)',
            pointRadius         : false,
            pointColor          : 'rgba(210, 214, 222, 1)',
            pointStrokeColor    : '#c1c7d1',
            pointHighlightFill  : '#fff',
            pointHighlightStroke: 'rgba(220,220,220,1)',
            data                : lydata
          },
      ]
    }

    var barChartOptions = {
      responsive              : true,
      maintainAspectRatio     : false,
      datasetFill             : false
    }

    new Chart(barChartCanvas, {
      type: 'bar',
      data: barChartData,
      options: barChartOptions
    })
  })
</script>
<script>
    $(document).ready(function () {
        // 현재 페이지 URL을 가져옵니다.
        var currentPageUrl = window.location.href;

        // 회원정보 메뉴의 하위 항목 중 현재 페이지와 일치하는 항목을 찾아서 활성화합니다.
        $('.nav-treeview .nav-link').each(function () {
            // 현재 페이지 URL이 해당 항목의 링크 URL과 일치하는지 확인합니다.
            if (currentPageUrl.includes($(this).attr('href'))) {
                // 일치하면 해당 항목에 'active' 클래스를 추가합니다.
                $(this).addClass('active');
                // 해당 항목이 속한 상위 항목인 '회원관리' 메뉴도 활성화합니다.
                $(this).closest('.nav-item.menu-close').addClass('menu-open').children('.nav-link').addClass('active');
            }
        });
    });
</script>

</body>
</html>
