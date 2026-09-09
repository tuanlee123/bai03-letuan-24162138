package vn.iotstar.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;
import vn.iotstar.model.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.util.EmailUtil;

@Controller
public class ForgotPasswordController {

    @Autowired
    private IUserService userService;

    // 1. Mở trang Quên mật khẩu
    @GetMapping("/forgot-password")
    public String showForgotPasswordForm() {
        return "web/forgot-password";
    }

    // 2. Xử lý gửi OTP qua Email
    @PostMapping("/forgot-password")
    public String handleForgotPassword(@RequestParam("email") String email,
                                       HttpSession session,
                                       Model model) {
        User user = userService.findByEmail(email);

        if (user == null) {
            model.addAttribute("error", "Email này không tồn tại trong hệ thống!");
            return "web/forgot-password";
        }

        String otp = EmailUtil.generateOTP();
        session.setAttribute("resetOTP", otp);
        session.setAttribute("resetEmail", email);
        session.setAttribute("resetUsername", user.getUsername());

        String content = "<h3>Mã OTP đặt lại mật khẩu của bạn là: <b style='color:red; font-size:20px;'>" + otp + "</b></h3>"
                + "<p>Mã này dùng để xác nhận khôi phục mật khẩu. Tuyệt đối không chia sẻ mã này.</p>";
        EmailUtil.sendEmail(email, "Xác nhận OTP đặt lại mật khẩu", content);

        return "redirect:/reset-password";
    }

    // 3. Mở trang Đặt lại mật khẩu
    @GetMapping("/reset-password")
    public String showResetPasswordForm() {
        return "web/reset-password";
    }

    // 4. Xác thực OTP và cập nhật mật khẩu mới
    @PostMapping("/reset-password")
    public String handleResetPassword(@RequestParam("otp") String inputOtp,
                                      @RequestParam("newPassword") String newPassword,
                                      @RequestParam("confirmPassword") String confirmPassword,
                                      HttpSession session,
                                      Model model) {
        String sessionOtp = (String) session.getAttribute("resetOTP");
        String username = (String) session.getAttribute("resetUsername");

        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error", "Mật khẩu xác nhận không khớp!");
            return "web/reset-password";
        }

        if (sessionOtp != null && sessionOtp.equals(inputOtp) && username != null) {
            userService.updatePassword(username, newPassword);

            session.removeAttribute("resetOTP");
            session.removeAttribute("resetEmail");
            session.removeAttribute("resetUsername");

            model.addAttribute("message", "Đổi mật khẩu thành công! Hãy đăng nhập lại.");
            return "web/login";
        } else {
            model.addAttribute("error", "Mã OTP không chính xác!");
            return "web/reset-password";
        }
    }
}