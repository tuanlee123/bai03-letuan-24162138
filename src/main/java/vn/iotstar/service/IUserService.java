package vn.iotstar.service;

import vn.iotstar.model.User;
import java.util.List;

public interface IUserService {
    // Xác thực đăng nhập
    User login(String username, String password);

    // Thêm mới / Đăng ký người dùng
    void insert(User user);

    // Cập nhật thông tin User
    void update(User user);

    // Cập nhật riêng hồ sơ (Profile)
    void updateProfile(int id, String fullname, String phone, String images);

    // Xóa người dùng theo ID
    void delete(int id);

    // Tìm theo ID
    User findById(int id);

    // Tìm theo Username
    User findByUsername(String username);

    // Tìm theo Email
    User findByEmail(String email);

    // Cập nhật mật khẩu mới
    void updatePassword(String username, String newPassword);

    // Kiểm tra trùng username hoặc email khi đăng ký
    boolean checkExistUsername(String username);
    boolean checkExistEmail(String email);

    // Lấy toàn bộ danh sách User
    List<User> findAll();
}