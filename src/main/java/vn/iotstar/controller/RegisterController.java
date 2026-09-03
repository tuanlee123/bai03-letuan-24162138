package vn.iotstar.controller;

import java.io.IOException;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.dao.impl.UserDaoImpl;
import vn.iotstar.model.User;

@WebServlet(urlPatterns = {"/register", "/verify-otp"})
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserDaoImpl userDao = new UserDaoImpl();

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
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String url = req.getRequestURI();

        if (url.contains("register")) {
            String email = req.getParameter("email");
            String username = req.getParameter("username");
            String pass = req.getParameter("password");

            // Tạo mã OTP ngẫu nhiên
            String otp = String.valueOf((int) ((Math.random() * 900000) + 100000));

            User user = new User();
            user.setEmail(email);
            user.setUsername(username);
            user.setPassword(pass);
            user.setRoleid(3);
            user.setCreatedDate(new Date());
            user.setOtpCode(otp);

            userDao.insertRegister(user);

            // Lưu tạm thông tin vào Session để trang verify-otp kiểm tra
            req.getSession().setAttribute("emailOtp", email);
            req.getSession().setAttribute("serverOtp", otp);

            resp.sendRedirect(req.getContextPath() + "/verify-otp");
        } else if (url.contains("verify-otp")) {
            String enteredOtp = req.getParameter("otp");
            String serverOtp = (String) req.getSession().getAttribute("serverOtp");

            if (serverOtp != null && serverOtp.equals(enteredOtp)) {
                req.getSession().removeAttribute("serverOtp");
                resp.sendRedirect(req.getContextPath() + "/login");
            } else {
                req.setAttribute("error", "Mã OTP không chính xác!");
                req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
            }
        }
    }
}