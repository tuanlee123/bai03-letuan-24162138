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

@WebServlet(urlPatterns = {"/forgot-password", "/reset-password"})
public class ForgotPasswordController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=UTF-8");
        req.setCharacterEncoding("UTF-8");

        String action = req.getServletPath();
        if ("/forgot-password".equals(action)) {
            req.getRequestDispatcher("/views/web/forgot-password.jsp").include(req, resp);
        } else if ("/reset-password".equals(action)) {
            req.getRequestDispatcher("/views/web/reset-password.jsp").include(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=UTF-8");
        req.setCharacterEncoding("UTF-8");

        String action = req.getServletPath();
        HttpSession session = req.getSession();

        if ("/forgot-password".equals(action)) {
            String email = req.getParameter("email");
            User user = userService.findByEmail(email);

            if (user == null) {
                req.setAttribute("error", "Email này không tồn tại trong hệ thống!");
                req.getRequestDispatcher("/views/web/forgot-password.jsp").include(req, resp);
                return;
            }

            String otp = EmailUtil.generateOTP();
            session.setAttribute("resetOTP", otp);
            session.setAttribute("resetEmail", email);
            session.setAttribute("resetUsername", user.getUsername());

            String content = "<h3>Mã OTP đặt lại mật khẩu của bạn là: <b style='color:red; font-size:20px;'>" + otp + "</b></h3>"
                    + "<p>Mã này dùng để xác nhận khôi phục mật khẩu. Tuyệt đối không chia sẻ mã này.</p>";
            EmailUtil.sendEmail(email, "Xác nhận OTP đặt lại mật khẩu", content);

            resp.sendRedirect(req.getContextPath() + "/reset-password");

        } else if ("/reset-password".equals(action)) {
            String inputOtp = req.getParameter("otp");
            String newPassword = req.getParameter("newPassword");
            String confirmPassword = req.getParameter("confirmPassword");

            String sessionOtp = (String) session.getAttribute("resetOTP");
            String username = (String) session.getAttribute("resetUsername");

            if (!newPassword.equals(confirmPassword)) {
                req.setAttribute("error", "Mật khẩu xác nhận không khớp!");
                req.getRequestDispatcher("/views/web/reset-password.jsp").include(req, resp);
                return;
            }

            if (sessionOtp != null && sessionOtp.equals(inputOtp) && username != null) {
                userService.updatePassword(username, newPassword);

                session.removeAttribute("resetOTP");
                session.removeAttribute("resetEmail");
                session.removeAttribute("resetUsername");

                req.setAttribute("message", "Đổi mật khẩu thành công! Hãy đăng nhập lại.");
                req.getRequestDispatcher("/views/web/login.jsp").include(req, resp);
            } else {
                req.setAttribute("error", "Mã OTP không chính xác!");
                req.getRequestDispatcher("/views/web/reset-password.jsp").include(req, resp);
            }
        }
    }
}