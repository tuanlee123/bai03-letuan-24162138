package vn.iotstar.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vn.iotstar.model.Category;

import java.util.List;
import java.util.Optional;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Integer> {

    // Tìm kiếm tương đối theo tên (phục vụ search)
    List<Category> findByCategorynameContainingIgnoreCase(String keyword);

    // Tìm chính xác theo tên trả về Optional (dòng 76 cần phương thức này)
    Optional<Category> findByCategoryname(String categoryname);
}