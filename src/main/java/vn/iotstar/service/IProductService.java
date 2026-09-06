package vn.iotstar.service;

import vn.iotstar.model.Product;
import java.util.List;

public interface IProductService {
    void insert(Product product);
    void update(Product product);
    void delete(int id);
    Product findById(int id);
    List<Product> findAll();

    List<Product> findTop10Latest();
    List<Product> findWithPaging(int page, int pageSize);
    int countTotal();
}