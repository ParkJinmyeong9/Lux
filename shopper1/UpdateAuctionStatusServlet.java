package shopper;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.JsonObject;

@WebServlet("/shopper/updateAuctionStatusServlet")
public class UpdateAuctionStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JsonObject jsonResponse = new JsonObject();

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int userId = Integer.parseInt(request.getParameter("userId"));
            String status = request.getParameter("status");
            int finalPrice = Integer.parseInt(request.getParameter("finalPrice"));

            AuctionMgr auctionMgr = new AuctionMgr();
            boolean updateResult = auctionMgr.updateAuctionStatusAndUserBalance(productId, userId, status, finalPrice);

            jsonResponse.addProperty("success", updateResult);
            if (updateResult) {
                jsonResponse.addProperty("message", "Auction status and user balance updated successfully.");
            } else {
                jsonResponse.addProperty("message", "Failed to update auction status and user balance.");
            }
        } catch (NumberFormatException e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Invalid input format.");
        } catch (Exception e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Internal server error: " + e.getMessage());
        }

        out.print(jsonResponse.toString());
        out.flush();
    }
}
