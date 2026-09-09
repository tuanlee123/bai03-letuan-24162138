package vn.iotstar.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import vn.iotstar.model.Product;
import vn.iotstar.repository.ProductRepository;
import vn.iotstar.service.IProductService;

import java.util.List;

@Service
public class ProductServiceImpl implements IProductService {

    @Autowired
    private ProductRepository productRepository;

    @Override
    public void insert(Product product) {
        productRepository.save(product);
    }

    @Override
    public void update(Product product) {
        productRepository.save(product);
    }

    @Override
    public void delete(int id) {
        productRepository.deleteById(id);
    }

    @Override
    public Product findById(int id) {
        return productRepository.findById(id).orElse(null);
    }

    @Override
    public List<Product> findAll() {
        return productRepository.findAll();
    }

    @Override
    public List<Product> findTop10Latest() {
        return productRepository.findTop10ByOrderByProductIdDesc();
    }

    @Override
    public List<Product> findWithPaging(int page, int pageSize) {
        // Trong Spring Data JPA, page bắt đầu từ 0
        int pageIndex = (page > 0) ? page - 1 : 0;
        Pageable pageable = PageRequest.of(pageIndex, pageSize);
        return productRepository.findAll(pageable).getContent();
    }

    @Override
    public int countTotal() {
        return (int) productRepository.count();
    }
}