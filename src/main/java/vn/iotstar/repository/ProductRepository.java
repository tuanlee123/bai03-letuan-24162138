package vn.iotstar.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vn.iotstar.model.Product;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Integer> {

    // Lấy 10 sản phẩm mới nhất sắp xếp giảm dần theo ID
    List<Product> findTop10ByOrderByProductIdDesc();
}