package vn.iotstar.connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private final String serverName = "localhost";
    private final String dbName = "ShoppingServiceMVC"; 
    private final String instanceName = "SQLEXPRESS"; // Khai báo rõ instance
    
    private final String userID = "sa";
    private final String password = "123456"; 

    public Connection getConnection() throws Exception {
        // Cấu trúc URL mới không cần cổng 1433
        String url = "jdbc:sqlserver://" + serverName + ";instanceName=" + instanceName + ";databaseName=" + dbName + ";encrypt=true;trustServerCertificate=true;";
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(url, userID, password);
    }

    public static void main(String[] args) {
        try {
            System.out.println("Đang kiểm tra kết nối...");
            System.out.println(new DBConnection().getConnection());
            System.out.println("Kết nối SQL Server THÀNH CÔNG!");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}