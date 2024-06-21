package shopper;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/shopper/reviewInsertServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class ReviewInsertServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String reviewTitle = request.getParameter("reviewTitle");
        String reviewText = request.getParameter("reviewText");
        int rating = Integer.parseInt(request.getParameter("Rating"));
        
        // 파일 업로드 처리
        Part filePart = request.getPart("photo");
        if (filePart != null) { // 파일이 제대로 전송되었는지 확인
            String fileName = request.getParameter("photoName"); 
            String DBuploadPath = "themes/images/review/"; // 업로드 폴더 경로 설정     
            String uploadPath = "C:\\Jsp\\myapp\\src\\main\\webapp\\shopper\\themes\\images\\review";

            
            // 업로드 폴더가 없다면 생성
            Path uploadDir = Paths.get(uploadPath);
            if (!Files.exists(uploadDir)) {
                Files.createDirectories(uploadDir);
            }

            // 파일 저장 경로 설정
            String filePath = uploadPath  + File.separator + fileName;
            String DBfilePath = DBuploadPath + fileName;
            // 파일 저장
            try (InputStream fileContent = filePart.getInputStream()) {
                Files.copy(fileContent, Paths.get(filePath));
            }

            // 제품 정보를 ProductBean에 설정
            ReviewBean review = new ReviewBean();
            review.setReviewName(reviewTitle);
            review.setContent(reviewText);
            review.setRating(rating);
            review.setRPhoto(DBfilePath);

            // ProductMgr를 사용하여 제품 정보를 데이터베이스에 삽입
            ReviewMgr rmgr = new ReviewMgr();
            rmgr.insertReview(review);

            // 제품 등록이 성공했다는 메시지를 클라이언트에게 응답
            response.getWriter().println("review inserted successfully!");
        } else {
            // 파일이 전송되지 않은 경우의 처리
            response.getWriter().println("File not uploaded. Please select a file.");
        }
    }
}
