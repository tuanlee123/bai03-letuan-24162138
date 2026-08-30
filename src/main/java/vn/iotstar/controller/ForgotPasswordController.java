package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.dao.impl.UserDaoImpl;
import vn.iotstar.model.User;
import vn.iotstar.util.EmailUtil;
import java.io.IOException;

@WebServlet(urlPatterns = {"/forgot-password", "/verify-forgot-otp", "/reset-password"})
public class ForgotPasswordController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDaoImpl userDao = new UserDaoImpl();

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
        String url = req.getRequestURI();
        HttpSession session = req.getSession();

        // 1. Bước nhập Email -> Gửi OTP
        if (url.contains("forgot-password")) {
            String email = req.getParameter("email");
            User user = userDao.findByEmail(email);

            if (user != null) {
                String otp = EmailUtil.generateOtp();
                userDao.updateOtp(email, otp);
                EmailUtil.sendOtpEmail(email, otp);
                
                session.setAttribute("resetEmail", email);
                resp.sendRedirect(req.getContextPath() + "/verify-forgot-otp");
            } else {
                req.setAttribute("error", "Email không tồn tại trong hệ thống!");
                req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
            }
        } 
        // 2. Bước xác thực OTP
        else if (url.contains("verify-forgot-otp")) {
            String otpInput = req.getParameter("otp");
            String email = (String) session.getAttribute("resetEmail");

            User user = userDao.findByEmail(email);
            if (user != null && otpInput.equals(user.getOtpCode())) {
                resp.sendRedirect(req.getContextPath() + "/reset-password");
            } else {
                req.setAttribute("error", "Mã OTP không đúng!");
                req.getRequestDispatcher("/views/verify-forgot-otp.jsp").forward(req, resp);
            }
        }
        // 3. Bước đổi mật khẩu mới
        else if (url.contains("reset-password")) {
            String newPassword = req.getParameter("newPassword");
            String email = (String) session.getAttribute("resetEmail");

            userDao.updatePassword(email, newPassword);
            userDao.updateOtp(email, null); // Xóa OTP cũ cho an toàn
            session.removeAttribute("resetEmail");
            
            resp.sendRedirect(req.getContextPath() + "/login?msg=reset_success");
        }
    }
}