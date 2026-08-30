package vn.iotstar.util;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;
import java.util.Random;

public class EmailUtil {
    // THAY BẰNG EMAIL VÀ MẬT KHẨU ỨNG DỤNG CỦA BẠN
    private static final String EMAIL = "email.cua.ban@gmail.com";
    private static final String PASSWORD = "mat-khau-ung-dung-gmail"; 

    public static void sendOtpEmail(String toEmail, String otp) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL, PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Mã xác thực OTP của bạn");
            message.setText("Chào bạn,\n\nMã OTP để xác thực tài khoản của bạn là: " + otp + "\n\nVui lòng không chia sẻ mã này cho bất kỳ ai.");

            Transport.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static String generateOtp() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000); // Sinh mã 6 số
        return String.valueOf(otp);
    }
}