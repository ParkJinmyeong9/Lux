package shopper.admin;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Vector;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

@WebServlet("/shopper/admin/StatusUpdateServlet")
public class StatusUpdateServlet extends HttpServlet {
    
	 @Override
	    public void init() throws ServletException {
	        super.init();

	        // 5초마다 상태 업데이트 작업을 실행합니다. (원하는 간격으로 조정 가능)
	        ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
	        scheduler.scheduleAtFixedRate(new StatusUpdateTask(), 0, 5, TimeUnit.SECONDS);
	    }

    // 내부 클래스로 상태 업데이트 작업을 수행하는 Task 정의
    public class StatusUpdateTask implements Runnable {
        @Override
        public void run() {
            // 현재 시각을 가져옵니다.
            long currentTime = System.currentTimeMillis();

            // 경매 상태를 업데이트할 때의 로직을 구현합니다.
            ProductMgr productMgr = new ProductMgr();
            Vector<ProductBean> auctionProducts = productMgr.productList();

            // 경매 중인 각 상품의 EndTime을 확인하여 상태를 업데이트합니다.
            for (ProductBean product : auctionProducts) {
                // 상태가 '경매중'이고, 현재 시각이 EndTime을 지나면 상태를 '낙찰'로 변경합니다.
                // 여기서는 getEndTime() 메서드가 String을 반환한다고 가정합니다.
                String endTimeString = product.getEndTime(); // 종료 시간을 문자열로 가져옵니다.

                // 문자열 형태의 종료 시간을 Date 객체로 변환합니다.
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                try {
                    Date endTime = dateFormat.parse(endTimeString);

                    // endTime과 currentTime을 비교하여 상태를 업데이트합니다.
                    if (endTime.getTime() < currentTime) {
                        // 상태를 '낙찰'로 변경하는 로직을 여기에 추가하세요.
                        boolean updatedStatus = productMgr.updateProducts(product.getProductID(), "낙찰");
                    }
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
