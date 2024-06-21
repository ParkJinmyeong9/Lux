package shopper;

import com.google.gson.Gson;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

public class FavoriteProductServlet extends HttpServlet {
    
    private Gson gson = new Gson(); // Gson 인스턴스 생성

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        int productId = Integer.parseInt(request.getParameter("productId"));
        String action = request.getParameter("action");
        
        boolean success = false;
        String message = "";

        // DB 연결 매니저 인스턴스를 가져옵니다.
        FavoriteProductMgr mgr = new FavoriteProductMgr();

        try {
            // '좋아요' 추가 또는 제거 로직
            if ("add".equals(action)) {
                success = mgr.addFavoriteProduct(userId, productId);
                message = success ? "Product added to favorites." : "Failed to add product to favorites.";
            } else if ("remove".equals(action)) {
                success = mgr.removeFavoriteProduct(userId, productId);
                message = success ? "Product removed from favorites." : "Failed to remove product from favorites.";
            }
        } catch (Exception e) {
            // 여기서 예외를 처리합니다. 예를 들어, 로그를 남길 수 있습니다.
            e.printStackTrace(); // 서버 로그에 예외 스택 트레이스를 출력
            message = "An error occurred."; // 사용자에게 반환할 메시지를 설정
            // success는 기본값 false를 유지합니다.
        }

        // JSON 응답 구성
        Map<String, Object> map = new HashMap<>();
        map.put("success", success);
        map.put("message", message);
        String jsonResponse = gson.toJson(map);

        // 클라이언트에게 응답 전송
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(jsonResponse);
        out.flush();
    }

}
