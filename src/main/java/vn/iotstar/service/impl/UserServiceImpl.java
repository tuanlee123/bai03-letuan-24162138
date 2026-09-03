package vn.iotstar.service.impl;

import vn.iotstar.dao.impl.UserDaoImpl;
import vn.iotstar.model.User; // ĐÃ ĐỔI IMPORT

public class UserServiceImpl {
    private final UserDaoImpl userDao = new UserDaoImpl();

    public User findById(int id) {
        return userDao.findById(id);
    }

    public void updateProfile(int userId, String fullname, String phone, String avatarFileName) {
        User user = userDao.findById(userId);
        if (user != null) {
            user.setFullname(fullname);
            user.setPhone(phone);
            if (avatarFileName != null && !avatarFileName.trim().isEmpty()) {
                user.setAvatar(avatarFileName);
            }
            userDao.update(user);
        }
    }
}