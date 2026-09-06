package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.model.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.service.impl.UserServiceImpl;

import java.io.IOException;

@WebServlet(urlPatterns = {"/login"})
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=UTF-8");
        req.setCharacterEncoding("UTF-8");

        // Đọc Cookie để tự động điền username nếu người dùng đã tích Remember Me trước đó
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("username".equals(cookie.getName())) {
                    req.setAttribute("username", cookie.getValue());
                    req.setAttribute("remember", true);
                    break;
                }
            }
        }

        req.getRequestDispatcher("/views/web/login.jsp").include(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=UTF-8");
        req.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String remember = req.getParameter("remember");

        // Server-side validation
        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            req.setAttribute("error", "Tên đăng nhập và mật khẩu không được để trống!");
            req.setAttribute("username", username);
            req.getRequestDispatcher("/views/web/login.jsp").include(req, resp);
            return;
        }

        // Xác thực tài khoản qua Service
        User user = userService.login(username.trim(), password.trim());

        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("account", user);

            // Xử lý Cookie Remember Me
            Cookie cookieUser = new Cookie("username", username.trim());
            if ("on".equals(remember) || "true".equals(remember)) {
                cookieUser.setMaxAge(60 * 60 * 24 * 7); // Lưu Cookie trong 7 ngày
            } else {
                cookieUser.setMaxAge(0); // Xóa bỏ Cookie nếu không tích chọn
            }
            cookieUser.setPath(req.getContextPath().isEmpty() ? "/" : req.getContextPath());
            resp.addCookie(cookieUser);

            // Phân quyền điều hướng theo roleid
            // roleid = 1: Admin, các role còn lại: User thông thường
            if (user.getRoleid() != null && user.getRoleid() == 1) {
                resp.sendRedirect(req.getContextPath() + "/admin/home");
            } else {
                resp.sendRedirect(req.getContextPath() + "/home");
            }
        } else {
            req.setAttribute("error", "Tài khoản hoặc mật khẩu không chính xác!");
            req.setAttribute("username", username);
            req.getRequestDispatcher("/views/web/login.jsp").include(req, resp);
        }
    }
}