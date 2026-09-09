package vn.iotstar.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.iotstar.model.User;
import vn.iotstar.repository.UserRepository;
import vn.iotstar.service.IUserService;

import java.util.List;

@Service
public class UserServiceImpl implements IUserService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public User login(String username, String password) {
        User user = this.findByUsername(username);
        if (user != null && password != null && password.equals(user.getPassword())) {
            return user;
        }
        return null;
    }

    @Override
    public void insert(User user) {
        userRepository.save(user);
    }

    @Override
    public void update(User user) {
        userRepository.save(user);
    }

    @Override
    public void updateProfile(int id, String fullname, String phone, String images) {
        User user = this.findById(id);
        if (user != null) {
            user.setFullname(fullname);
            user.setPhone(phone);
            if (images != null && !images.isEmpty()) {
                user.setImages(images);
                user.setAvatar(images);
            }
            userRepository.save(user);
        }
    }

    @Override
    public void delete(int id) {
        userRepository.deleteById(id);
    }

    @Override
    public User findById(int id) {
        return userRepository.findById(id).orElse(null);
    }

    @Override
    public User findByUsername(String username) {
        return userRepository.findByUsername(username).orElse(null);
    }

    @Override
    public User findByEmail(String email) {
        return userRepository.findByEmail(email).orElse(null);
    }

    @Override
    public void updatePassword(String username, String newPassword) {
        User user = this.findByUsername(username);
        if (user != null) {
            user.setPassword(newPassword);
            userRepository.save(user);
        }
    }

    @Override
    public boolean checkExistUsername(String username) {
        return userRepository.existsByUsername(username);
    }

    @Override
    public boolean checkExistEmail(String email) {
        return userRepository.existsByEmail(email);
    }

    @Override
    public List<User> findAll() {
        return userRepository.findAll();
    }

    @Override
    public List<User> search(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return userRepository.findAll();
        }
        String term = keyword.trim();
        return userRepository.findByUsernameContainingIgnoreCaseOrFullnameContainingIgnoreCaseOrEmailContainingIgnoreCase(term, term, term);
    }
}