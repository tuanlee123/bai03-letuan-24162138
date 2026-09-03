package vn.iotstar.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import vn.iotstar.model.User;
import vn.iotstar.service.impl.UserServiceImpl;

@WebServlet(urlPatterns = {"/profile"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,      // 1 MB
    maxFileSize = 1024 * 1024 * 5,         // 5 MB
    maxRequestSize = 1024 * 1024 * 10      // 10 MB
)
public class ProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserServiceImpl userService = new UserServiceImpl();
    
    // ĐƯỜNG DẪN MỚI: Lưu cố định ra ổ C
    private static final String UPLOAD_DIRECTORY = "C:/iotstar_uploads"; 

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("account");

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User user = userService.findById(currentUser.getId());
        req.setAttribute("user", user);
        req.getRequestDispatcher("/views/web/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("account");

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int userId = currentUser.getId(); 
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");

        Part filePart = req.getPart("image");
        String fileName = null;

        if (filePart != null && filePart.getSize() > 0) {
            String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            fileName = System.currentTimeMillis() + "_" + originalFileName;

            // Xử lý lưu ra ổ C
            File uploadDir = new File(UPLOAD_DIRECTORY);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs(); // Tự động tạo thư mục C:/iotstar_uploads nếu chưa có
            }
            filePart.write(UPLOAD_DIRECTORY + File.separator + fileName);
        }

        userService.updateProfile(userId, fullname, phone, fileName);

        User updatedUser = userService.findById(userId);
        session.setAttribute("account", updatedUser);

        req.setAttribute("message", "Cập nhật hồ sơ thành công!");
        req.setAttribute("user", updatedUser);
        req.getRequestDispatcher("/views/web/profile.jsp").forward(req, resp);
    }
}