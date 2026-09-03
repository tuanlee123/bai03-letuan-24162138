package vn.iotstar.service.impl;

import vn.iotstar.dao.IProductDao;
import vn.iotstar.dao.impl.ProductDao;
import vn.iotstar.model.Product;
import vn.iotstar.service.IProductService;
import java.util.List;

public class ProductServiceImpl implements IProductService {
    
    // Khởi tạo đối tượng từ tầng DAO
    private IProductDao productDao = new ProductDao();

    @Override
    public void insert(Product product) {
        productDao.insert(product);
    }

    @Override
    public void update(Product product) {
        productDao.update(product);
    }

    @Override
    public void delete(int productId) {
        try {
            productDao.delete(productId);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public Product findById(int productId) {
        return productDao.findById(productId);
    }

    @Override
    public List<Product> findAll() {
        return productDao.findAll();
    }

    @Override
    public List<Product> findAll(int page, int pagesize) {
        return productDao.findAll(page, pagesize);
    }

    @Override
    public int count() {
        return productDao.count();
    }

    @Override
    public List<Product> findTop10Latest() {
        return productDao.findTop10Latest();
    }
}