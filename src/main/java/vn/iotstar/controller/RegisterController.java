package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.model.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.EmailUtil;

import java.io.IOException;
import java.util.Date;

@WebServlet(urlPatterns = {"/register", "/verify-otp"})
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=UTF-8");
        req.setCharacterEncoding("UTF-8");

        String action = req.getServletPath();
        if ("/register".equals(action)) {
            req.getRequestDispatcher("/views/web/register.jsp").include(req, resp);
        } else if ("/verify-otp".equals(action)) {
            req.getRequestDispatcher("/views/web/verify-otp.jsp").include(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=UTF-8");
        req.setCharacterEncoding("UTF-8");

        String action = req.getServletPath();
        HttpSession session = req.getSession();

        if ("/register".equals(action)) {
            String username = req.getParameter("username");
            String fullname = req.getParameter("fullname");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String password = req.getParameter("password");
            String confirmPassword = req.getParameter("confirmPassword");

            if (!password.equals(confirmPassword)) {
                req.setAttribute("error", "Mật khẩu xác nhận không khớp!");
                req.getRequestDispatcher("/views/web/register.jsp").include(req, resp);
                return;
            }

            if (userService.findByUsername(username) != null) {
                req.setAttribute("error", "Tên đăng nhập đã tồn tại!");
                req.getRequestDispatcher("/views/web/register.jsp").include(req, resp);
                return;
            }

            if (userService.findByEmail(email) != null) {
                req.setAttribute("error", "Email này đã được sử dụng!");
                req.getRequestDispatcher("/views/web/register.jsp").include(req, resp);
                return;
            }

            // Tạo mã OTP ngẫu nhiên 6 chữ số
            String otp = EmailUtil.generateOTP();

            // Lưu tạm thông tin User chưa kích hoạt vào Session
            User tempUser = new User();
            tempUser.setUsername(username);
            tempUser.setFullname(fullname);
            tempUser.setEmail(email);
            tempUser.setPhone(phone);
            tempUser.setPassword(password);
            tempUser.setRoleid(2); // Role 2: User thông thường
            tempUser.setImages("avatar.png");
            tempUser.setCreatedDate(new Date());

            session.setAttribute("tempUser", tempUser);
            session.setAttribute("regOTP", otp);

            // Gửi email
            String content = "<h3>Mã OTP kích hoạt tài khoản của bạn là: <b style='color:red; font-size:20px;'>" + otp + "</b></h3>"
                    + "<p>Mã này có hiệu lực trong phiên đăng ký hiện tại. Vui lòng không chia sẻ cho ai khác.</p>";
            EmailUtil.sendEmail(email, "Kích hoạt tài khoản - Xác nhận OTP", content);

            resp.sendRedirect(req.getContextPath() + "/verify-otp");

        } else if ("/verify-otp".equals(action)) {
            String inputOtp = req.getParameter("otp");
            String sessionOtp = (String) session.getAttribute("regOTP");
            User tempUser = (User) session.getAttribute("tempUser");

            if (sessionOtp != null && sessionOtp.equals(inputOtp) && tempUser != null) {
                userService.insert(tempUser);

                session.removeAttribute("regOTP");
                session.removeAttribute("tempUser");

                req.setAttribute("message", "Kích hoạt tài khoản thành công! Bạn có thể đăng nhập ngay.");
                req.getRequestDispatcher("/views/web/login.jsp").include(req, resp);
            } else {
                req.setAttribute("error", "Mã OTP không hợp lệ hoặc đã hết hạn!");
                req.getRequestDispatcher("/views/web/verify-otp.jsp").include(req, resp);
            }
        }
    }
}