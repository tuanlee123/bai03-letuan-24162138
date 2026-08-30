package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.dao.impl.UserDaoImpl;
import vn.iotstar.model.User;
import vn.iotstar.util.EmailUtil;
import java.io.IOException;

@WebServlet(urlPatterns = {"/register", "/verify-otp"})
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDaoImpl userDao = new UserDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        if (url.contains("register")) {
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
        } else if (url.contains("verify-otp")) {
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        
        // 1. XỬ LÝ ĐĂNG KÝ
        if (url.contains("register")) {
            String email = req.getParameter("email");
            String username = req.getParameter("username");
            String pass = req.getParameter("password");

            // Tạo OTP và lưu User
            String otp = EmailUtil.generateOtp();
            User user = new User();
            user.setEmail(email);
            user.setUsername(username);
            user.setPassword(pass);
            user.setOtpCode(otp);

            userDao.insertRegister(user);
            
            // Gửi mail
            EmailUtil.sendOtpEmail(email, otp);
            
            req.getSession().setAttribute("emailOtp", email);
            resp.sendRedirect(req.getContextPath() + "/verify-otp");
        } 
        // 2. XỬ LÝ NHẬP OTP XÁC THỰC
        else if (url.contains("verify-otp")) {
            String otpInput = req.getParameter("otp");
            String email = (String) req.getSession().getAttribute("emailOtp");
            
            User user = userDao.findByEmail(email);
            if (user != null && user.getOtpCode().equals(otpInput)) {
                userDao.activateUser(email);
                req.getSession().removeAttribute("emailOtp");
                resp.sendRedirect(req.getContextPath() + "/login?msg=active_success");
            } else {
                req.setAttribute("error", "Mã OTP không chính xác!");
                req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
            }
        }
    }
}