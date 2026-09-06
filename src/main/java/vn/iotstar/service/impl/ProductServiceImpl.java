package vn.iotstar.service.impl;

import vn.iotstar.dao.IProductDao;
import vn.iotstar.dao.impl.ProductDaoImpl;
import vn.iotstar.model.Product;
import vn.iotstar.service.IProductService;

import java.util.List;

public class ProductServiceImpl implements IProductService {
    private IProductDao productDao = new ProductDaoImpl();

    @Override
    public void insert(Product product) {
        productDao.insert(product);
    }

    @Override
    public void update(Product product) {
        productDao.update(product);
    }

    @Override
    public void delete(int id) {
        productDao.delete(id);
    }

    @Override
    public Product findById(int id) {
        return productDao.findById(id);
    }

    @Override
    public List<Product> findAll() {
        return productDao.findAll();
    }

    @Override
    public List<Product> findTop10Latest() {
        return productDao.findTop10Latest();
    }

    @Override
    public List<Product> findWithPaging(int page, int pageSize) {
        return productDao.findWithPaging(page, pageSize);
    }

    @Override
    public int countTotal() {
        return productDao.countTotal();
    }
}