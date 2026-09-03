package vn.iotstar.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.dao.impl.UserDaoImpl;
import vn.iotstar.model.User;

@WebServlet(urlPatterns = {"/login"})
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserDaoImpl userDao = new UserDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Đọc cookie (nếu có) để đẩy ra giao diện JSP điền sẵn vào ô input
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("cookieUser")) {
                    req.setAttribute("savedUser", cookie.getValue());
                }
                if (cookie.getName().equals("cookiePass")) {
                    req.setAttribute("savedPass", cookie.getValue());
                }
            }
        }
        req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String usernameOrEmail = req.getParameter("email");
        if (usernameOrEmail == null) {
            usernameOrEmail = req.getParameter("username");
        }
        String password = req.getParameter("password");
        
        // Nhận giá trị từ ô checkbox "Nhớ mật khẩu" trên form
        String remember = req.getParameter("remember"); 

        User user = userDao.login(usernameOrEmail, password);

        if (user != null) {
            // Đăng nhập thành công -> Lưu Session
            HttpSession session = req.getSession();
            session.setAttribute("account", user);

            // XỬ LÝ COOKIE (Yêu cầu 1)
            Cookie cookieU = new Cookie("cookieUser", usernameOrEmail);
            Cookie cookieP = new Cookie("cookiePass", password);
            
            if (remember != null) {
                // Tích chọn -> Sống 30 ngày
                cookieU.setMaxAge(60 * 60 * 24 * 30);
                cookieP.setMaxAge(60 * 60 * 24 * 30);
            } else {
                // Không chọn -> Xóa Cookie ngay lập tức
                cookieU.setMaxAge(0);
                cookieP.setMaxAge(0);
            }
            resp.addCookie(cookieU);
            resp.addCookie(cookieP);

            // Phân quyền chuyển trang
            if (user.getRoleid() != null && user.getRoleid() == 1) {
                resp.sendRedirect(req.getContextPath() + "/admin/products");
            } else {
                resp.sendRedirect(req.getContextPath() + "/home");
            }
        } else {
            req.setAttribute("error", "Email hoặc mật khẩu không đúng!");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        }
    }
}