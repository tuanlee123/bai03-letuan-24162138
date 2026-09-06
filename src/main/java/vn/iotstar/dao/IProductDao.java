package vn.iotstar.dao;

import vn.iotstar.model.Product;
import java.util.List;

public interface IProductDao {
    void insert(Product product);
    void update(Product product);
    void delete(int id);
    Product findById(int id);
    List<Product> findAll();
    
    // Các hàm phục vụ trang chủ và phân trang
    List<Product> findTop10Latest();
    List<Product> findWithPaging(int page, int pageSize);
    int countTotal();
}