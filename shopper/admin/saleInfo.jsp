<!-- saleInfo.jsp -->
<%@page import="shopper.admin.AuctionsMgr"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="header.jsp"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.min.js"></script>


<style>
  .ui-datepicker {
    z-index: 9999 !important;
  }
  .container {
        display: flex;
        flex-direction: row;
        align-items: center;
    }
  h4 {
        margin-right: 10px;
    }
    input[type="text"] {
        flex: 1;
    }
</style>
<meta charset="UTF-8">
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<div class="content-header">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6">
					<h1 class="m-0">Sale Infomation</h1>
				</div>
				<!-- /.col -->
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item"><a href="saleInfo.jsp">쇼핑몰관리</a></li>
						<li class="breadcrumb-item active">매출현황</li>
					</ol>
				</div>
				<!-- /.col -->
			</div>
			<!-- /.row -->
		</div>
		<!-- /.container-fluid -->
	</div>
	<!-- /.content-header -->

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-md-6">
          
            <!-- PIE CHART -->
            <div class="card card-danger">
              <div class="card-header">
                <h3 class="card-title">Pie Chart</h3>

                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                  <button type="button" class="btn btn-tool" data-card-widget="remove">
                    <i class="fas fa-times"></i>
                  </button>
                </div>
              </div>
              <div class="card-body">
                <canvas id="pieChart" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%;"></canvas>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->

          </div>
          <!-- /.col (LEFT) -->
          <div class="col-md-6">

            <!-- BAR CHART -->
            <div class="card card-success">
              <div class="card-header">
                <h3 class="card-title">주간 통계</h3>
                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                  <button type="button" class="btn btn-tool" data-card-widget="remove">
                    <i class="fas fa-times"></i>
                  </button>
                </div>
              </div>
			<div class="card-body">
				<div class="card-body table-responsive p-0" style="height: 300px;">
                <table class="table table-head-fixed text-nowrap">
                  <%
                   	AuctionsMgr auctionMgr = new AuctionsMgr();
                  	int totalSales = auctionMgr.weekSale();
                  	int ltotalSales = auctionMgr.lweekSale();
                  	int totalBuy = auctionMgr.weekBuy();
                  	int ltotalBuy = auctionMgr.lweekBuy();
                  	int totalUpload = auctionMgr.weekUpload();
                  	int ltotalUpload = auctionMgr.lweekUpload();
                  	int totalMale = auctionMgr.weekMale();
                  	int ltotalMale = auctionMgr.lweekMale();
                  	int totalFemale = auctionMgr.weekFemale();
                  	int ltotalFemale = auctionMgr.lweekFemale();
                   %>
                   <thead>
                   	<tr>
                   	<th></th>
                   	<th>이번주</th>
                   	<th>지난주</th>
                   	</tr>
                   </thead>
                  <tbody>
					<tr>
						<td style="text-align: left">등록된 상품</td>
                    	<td><%=totalUpload %></td>
                    	<td><%=ltotalUpload %></td>
                    </tr>
                    <tr>
                    	<td style="text-align: left">판매된 상품</td>
                    	<td><%=totalBuy %></td>
                    	<td><%=ltotalBuy %></td>
                    </tr>
                    <tr>
                    	<td style="text-align: left">총 매출액</td>
                    	<td><%=totalSales %></td>
                    	<td><%=ltotalSales %></td>
                    </tr>
                    <tr>
                    	<td style="text-align: left">판매된 남성상품</td>
                    	<td><%=totalMale %></td>
                    	<td><%=ltotalMale %></td>
                    </tr>
					<tr>
						<td style="text-align: left">판매된 여성상품</td>
                    	<td><%=totalFemale%></td>
                    	<td><%=ltotalFemale%></td>
                    </tr>
                  </tbody>
                </table>
              </div>
			</div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
          </div>
          <!-- /.col (RIGHT) -->
        </div>
        <div class="col">
        <!-- BAR CHART -->
            <div class="card card-success">
              <div class="card-header">
                <h3 class="card-title">월별 매출 현황</h3>

                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                  <button type="button" class="btn btn-tool" data-card-widget="remove">
                    <i class="fas fa-times"></i>
                  </button>
                </div>
              </div>
              <div class="card-body">
                <div class="chart">
                  <canvas id="barChart" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%;"></canvas>
                </div>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
        </div>
        <!-- /.row -->
      </div><!-- /.container-fluid -->
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
<script>
jQuery.noConflict();
jQuery(function($) {
  $("#datepicker").datepicker({
    dateFormat: "yy-mm-dd", // YYYY-MM-DD 형식으로 설정
    onSelect: function(dateText) {
      console.log("선택한 날짜:", dateText);
    }
  });
});


document.addEventListener("DOMContentLoaded", function() {
    var button = document.querySelector(".date_select");
    button.addEventListener("click", function() {
        // 선택한 날짜 가져오기
        var selectedDate = document.getElementById("datepicker").value;

        // 서블릿으로 데이터를 전송하는 XMLHttpRequest 객체 생성
        var xhr = new XMLHttpRequest();

        // POST 방식으로 데이터를 서블릿으로 전송
        xhr.open("GET", "PrintSaleServlet", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        // 전송할 데이터
        var data = selectedDate;
		console.log(data);
        // 서버로 데이터 전송
        xhr.send(data);

        // 응답 처리
        xhr.onreadystatechange = function() {
            if (xhr.readyState == XMLHttpRequest.DONE) {
                if (xhr.status == 200) {
                    // 서버로부터 응답을 받았을 때 실행할 코드
                    console.log("서버로부터 응답 받음");
                } else {
                    console.log("서버 응답 실패");
                }
            }
        };
    });
});
</script>
<script>
document.getElementById('sellLink').addEventListener('click', function() {
    // 로그인 상태를 확인합니다. 실제 구현에서는 서버에서 이 값을 설정해야 합니다.
    // 예시 코드에서는 JSP 스크립틀릿을 사용하여 로그인 상태를 체크합니다.
    <% if (loggedInUser == null) { %>
        // 로그인하지 않은 상태면 로그인 페이지로 리다이렉트합니다.
        window.location.href = 'login.jsp';
    <% } else { %>
        // 로그인 상태면 판매 페이지로 이동합니다.
        window.location.href = './product_register.jsp';
    <% } %>
});
</script>

<%@ include file="saleFooter.jsp"%>