package shopper;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/shopper/updateStateSuccessServlet")
public class UpdateStateSuccessServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UpdateStateSuccessServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get product ID from request parameter
        String productIdString = request.getParameter("productId");
        
        int productId = -1; // Default value for invalid productId

        try {
            productId = Integer.parseInt(productIdString);
        } catch (NumberFormatException e) {
            // Log the error if productId is not a valid integer
            System.err.println("Invalid productId: " + productIdString);
            e.printStackTrace();
        }

        // Create a ProductBean object with the updated status
        ProductBean bean = new ProductBean();
        bean.setProductID(productId);
        bean.setStatus("낙찰"); // Set the status to "낙찰"

        // Update the product status using ProductMgr
        ProductMgr mgr = new ProductMgr();
        mgr.updateProductStatus(bean);

        // Send a success response
        response.setContentType("text/plain");
        response.getWriter().write("Product status updated successfully!");
    }

}
