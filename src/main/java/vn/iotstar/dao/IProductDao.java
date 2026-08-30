package vn.iotstar.dao;

import vn.iotstar.entity.Product;
import java.util.List;

public interface IProductDao {
    void insert(Product product);
    void update(Product product);
    void delete(int productId) throws Exception;
    Product findById(int productId);
    List<Product> findAll();
    
    // Hàm phân trang (6 SP/trang)
    List<Product> findAll(int page, int pagesize);
    int count();
    
    // Hàm lấy 10 SP mới nhất
    List<Product> findTop10Latest();
}