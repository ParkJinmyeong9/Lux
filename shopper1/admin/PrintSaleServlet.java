package shopper.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class PrintSaleServlet
 */
@WebServlet("/admin/PrintSaleServlet")
public class PrintSaleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String selectedDate = request.getParameter("selectedDate");

	    // 받은 데이터 처리
	    // 예를 들어, 선택한 날짜를 콘솔에 출력하거나 데이터베이스에 저장하는 등의 작업을 수행할 수 있습니다.
	    System.out.println("선택한 날짜: " + selectedDate);
	}

}
