package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import vn.iotstar.model.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.Constant;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@WebServlet(urlPatterns = {"/profile"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class ProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IUserService userService = new UserServiceImpl();

    // Hàm lấy tên file theo chuẩn Multipart
    private String getFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf("=") + 2, content.length() - 1).replace("\"", "");
            }
        }
        return "default.file";
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=UTF-8");
        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("account") : null;

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Lấy dữ liệu mới nhất từ CSDL
        User user = userService.findById(currentUser.getId());
        req.setAttribute("user", user);

        // Bắt buộc dùng include để SiteMesh bọc giao diện
        req.getRequestDispatcher("/views/web/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=UTF-8");
        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("account") : null;

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");

        // Server-side validation
        if (fullname == null || fullname.trim().length() < 2) {
            req.setAttribute("error", "Họ và tên không được để trống và phải có ít nhất 2 ký tự!");
            req.setAttribute("user", currentUser);
            req.getRequestDispatcher("/views/web/profile.jsp").forward(req, resp);
            return;
        }

        if (phone == null || !phone.matches("0[0-9]{9}")) {
            req.setAttribute("error", "Số điện thoại phải gồm 10 chữ số và bắt đầu bằng số 0!");
            req.setAttribute("user", currentUser);
            req.getRequestDispatcher("/views/web/profile.jsp").forward(req, resp);
            return;
        }

        User user = userService.findById(currentUser.getId());
        user.setFullname(fullname.trim());
        user.setPhone(phone.trim());

        // Xử lý upload file avatar qua Multipart
        String uploadPath = Constant.DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        try {
            Part part = req.getPart("image");
            if (part != null && part.getSize() > 0) {
                String submittedName = Paths.get(getFileName(part)).getFileName().toString();
                int dotIndex = submittedName.lastIndexOf(".");
                String ext = (dotIndex > 0) ? submittedName.substring(dotIndex + 1) : "png";
                String newFileName = "avatar_" + System.currentTimeMillis() + "." + ext;

                // Xóa ảnh đại diện cũ trên ổ đĩa nếu có
                String oldImage = user.getImages();
                if (oldImage != null && !oldImage.startsWith("http") && !"avatar.png".equals(oldImage)) {
                    deleteOldFile(uploadPath + File.separator + oldImage);
                }

                part.write(uploadPath + File.separator + newFileName);
                user.setImages(newFileName);
                user.setAvatar(newFileName);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Cập nhật vào DB qua JPA
        userService.update(user);

        // Cập nhật lại session để navbar/topbar hiển thị đúng
        session.setAttribute("account", user);

        req.setAttribute("user", user);
        req.setAttribute("message", "Cập nhật thông tin hồ sơ thành công!");
        req.getRequestDispatcher("/views/web/profile.jsp").forward(req, resp);
    }

    private void deleteOldFile(String filePath) {
        try {
            Path path = Paths.get(filePath);
            Files.deleteIfExists(path);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}