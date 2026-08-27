package vn.iotstar.connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private final String serverName = "localhost";
    private final String dbName = "ShoppingServiceMVC"; // Đảm bảo đúng tên database
    private final String portNumber = "1433";
    private final String userID = "sa";
    private final String password = "123"; // Đổi thành mật khẩu SA của bạn

    public Connection getConnection() throws Exception {
        // Thêm loginTimeout=5 để nếu lỗi kết nối sẽ văng lỗi ngay trong 5s chứ không quay mãi
        String url = "jdbc:sqlserver://" + serverName + ":" + portNumber 
                + ";databaseName=" + dbName 
                + ";encrypt=true;trustServerCertificate=true;loginTimeout=5";
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(url, userID, password);
    }
}