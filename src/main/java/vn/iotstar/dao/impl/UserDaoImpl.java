package vn.iotstar.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import vn.iotstar.connection.DBConnection;
import vn.iotstar.dao.UserDao;
import vn.iotstar.model.User;

public class UserDaoImpl implements UserDao {
	@Override
	public void insert(User user) {
		String sql = "INSERT INTO [User](email, username, fullname, password, avatar, roleid, phone, createdDate) VALUES (?,?,?,?,?,?,?,?)";
		try {
			Connection conn = new DBConnection().getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, user.getEmail());
			ps.setString(2, user.getUsername());
			ps.setString(3, user.getFullname());
			ps.setString(4, user.getPassword());
			ps.setString(5, user.getAvatar());
			ps.setInt(6, user.getRoleid());
			ps.setString(7, user.getPhone());
			ps.setDate(8, user.getCreatedDate());
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public boolean checkExistEmail(String email) {
		boolean duplicate = false;
		String sql = "SELECT * FROM [User] WHERE email = ?";
		try {
			Connection conn = new DBConnection().getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				duplicate = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return duplicate;
	}

	@Override
	public boolean checkExistUsername(String username) {
		boolean duplicate = false;
		String sql = "SELECT * FROM [User] WHERE username = ?";
		try {
			Connection conn = new DBConnection().getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				duplicate = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return duplicate;
	}

	@Override
	public User get(String username) {
		String sql = "SELECT * FROM [User] WHERE username = ?";
		try {
			Connection conn = new DBConnection().getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				User user = new User();
				user.setId(rs.getInt("id"));
				user.setEmail(rs.getString("email"));
				user.setUsername(rs.getString("username"));
				user.setFullname(rs.getString("fullname"));
				user.setPassword(rs.getString("password"));
				user.setAvatar(rs.getString("avatar"));
				user.setRoleid(rs.getInt("roleid"));
				user.setPhone(rs.getString("phone"));
				user.setCreatedDate(rs.getDate("createdDate"));
				return user;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}