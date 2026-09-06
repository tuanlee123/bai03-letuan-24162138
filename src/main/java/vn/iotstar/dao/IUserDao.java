package vn.iotstar.dao;

import vn.iotstar.model.User;
import java.util.List;

public interface IUserDao {
    // Đăng ký, thêm mới User
    void insert(User user);

    // Cập nhật thông tin User (Profile, Avatar, Thông tin cá nhân)
    void update(User user);

    // Xóa User theo id
    void delete(int id);

    // Tìm User theo ID (Primary key)
    User findById(int id);

    // Tìm User theo Username (Phục vụ Đăng nhập & Check trùng lúc Đăng ký)
    User findByUsername(String username);

    // Tìm User theo Email (Phục vụ Quên mật khẩu & Check trùng lúc Đăng ký)
    User findByEmail(String email);

    // Cập nhật mật khẩu mới (Phục vụ Quên mật khẩu / Reset Password)
    void updatePassword(String username, String newPassword);

    // Lấy toàn bộ danh sách User (Quản trị viên)
    List<User> findAll();
}