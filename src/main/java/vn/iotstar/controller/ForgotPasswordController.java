package vn.iotstar.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.dao.impl.UserDaoImpl;
import vn.iotstar.model.User;
// Giả định bạn đã có EmailUtil giống như ở phần Đăng ký (RegisterController)
import vn.iotstar.util.EmailUtil; 

@WebServlet(urlPatterns = {"/forgot-password", "/verify-forgot-otp", "/reset-password"})
public class ForgotPasswordController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserDaoImpl userDao = new UserDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        if (url.contains("forgot-password")) {
            req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
        } else if (url.contains("verify-forgot-otp")) {
            req.getRequestDispatcher("/views/verify-forgot-otp.jsp").forward(req, resp);
        } else if (url.contains("reset-password")) {
            req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        
        String url = req.getRequestURI();
        HttpSession session = req.getSession();

        // BƯỚC 1: Xử lý khi user nộp Email để xin cấp lại mật khẩu
        if (url.contains("forgot-password")) {
            String email = req.getParameter("email");
            User user = userDao.findByUsernameOrEmail(email);

            if (user != null) {
                // 1. Tạo OTP ngẫu nhiên 6 số
                String otp = String.valueOf((int) ((Math.random() * 900000) + 100000));
                
                // 2. Gửi Email (Tái sử dụng EmailUtil của bạn)
                EmailUtil.sendOtpEmail(email, otp);
                
                // 3. Lưu tạm vào Session để bước sau đối chiếu
                session.setAttribute("forgotEmail", email);
                session.setAttribute("forgotOtp", otp);
                
                resp.sendRedirect(req.getContextPath() + "/verify-forgot-otp");
            } else {
                req.setAttribute("error", "Email không tồn tại trong hệ thống!");
                req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
            }
        } 
        // BƯỚC 2: Kiểm tra mã OTP người dùng nhập vào
        else if (url.contains("verify-forgot-otp")) {
            String enteredOtp = req.getParameter("otp");
            String serverOtp = (String) session.getAttribute("forgotOtp");

            if (serverOtp != null && serverOtp.equals(enteredOtp)) {
                // Xác thực thành công, cho phép đổi mật khẩu
                session.removeAttribute("forgotOtp"); 
                session.setAttribute("canReset", true); // Đặt cờ cho phép reset
                resp.sendRedirect(req.getContextPath() + "/reset-password");
            } else {
                req.setAttribute("error", "Mã OTP không chính xác hoặc đã hết hạn!");
                req.getRequestDispatcher("/views/verify-forgot-otp.jsp").forward(req, resp);
            }
        } 
        // BƯỚC 3: Cập nhật mật khẩu mới vào CSDL
        else if (url.contains("reset-password")) {
            // Kiểm tra xem có được phép reset không (chống bypass URL)
            Boolean canReset = (Boolean) session.getAttribute("canReset");
            String email = (String) session.getAttribute("forgotEmail");
            
            if (canReset != null && canReset && email != null) {
                String newPassword = req.getParameter("newPassword");
                
                User user = userDao.findByUsernameOrEmail(email);
                if (user != null) {
                    user.setPassword(newPassword); // Ở thực tế sẽ mã hóa BCrypt tại đây
                    userDao.update(user);
                }
                
                // Xóa mọi dữ liệu rác trong session sau khi xong việc
                session.removeAttribute("forgotEmail");
                session.removeAttribute("canReset");
                
                resp.sendRedirect(req.getContextPath() + "/login?msg=Reset_Success");
            } else {
                resp.sendRedirect(req.getContextPath() + "/forgot-password");
            }
        }
    }
}