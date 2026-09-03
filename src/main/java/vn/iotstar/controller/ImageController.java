package vn.iotstar.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/image"})
public class ImageController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // ĐƯỜNG DẪN MỚI: Phải trùng khớp với ProfileController
    private static final String UPLOAD_DIRECTORY = "C:/iotstar_uploads";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        String fileName = req.getParameter("fname");
        if (fileName == null || fileName.trim().isEmpty()) {
            return;
        }

        // Tìm ảnh trong ổ C
        File file = new File(UPLOAD_DIRECTORY, fileName);

        if (file.exists()) {
            String mimeType = getServletContext().getMimeType(file.getName());
            if (mimeType == null) {
                mimeType = "application/octet-stream";
            }
            resp.setContentType(mimeType);
            resp.setContentLength((int) file.length());

            try (FileInputStream in = new FileInputStream(file);
                 OutputStream out = resp.getOutputStream()) {
                in.transferTo(out);
            }
        } else {
            // Nếu không tìm thấy ảnh thì báo 404 (Không có ảnh)
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}