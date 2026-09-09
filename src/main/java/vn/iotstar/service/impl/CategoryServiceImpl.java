package vn.iotstar.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import vn.iotstar.model.Category;
import vn.iotstar.repository.CategoryRepository;
import vn.iotstar.service.ICategoryService;

@Service
public class CategoryServiceImpl implements ICategoryService {

    @Autowired
    private CategoryRepository categoryRepository;

    @Override
    public List<Category> findAll() {
        return categoryRepository.findAll();
    }

    @Override
    public Category findById(int id) {
        return categoryRepository.findById(id).orElse(null);
    }

    @Override
    public List<Category> searchByName(String keyword) {
        if (keyword != null && !keyword.trim().isEmpty()) {
            return categoryRepository.findByCategorynameContainingIgnoreCase(keyword.trim());
        }
        return categoryRepository.findAll();
    }

    @Override
    public void insert(Category category) {
        Category cate = this.findByCategoryname(category.getCategoryname());
        if (cate == null) {
            categoryRepository.save(category);
        }
    }

    @Override
    public void update(Category category) {
        Category cate = this.findById(category.getCategoryId());
        if (cate != null) {
            categoryRepository.save(category);
        }
    }

    @Override
    public void delete(int id) {
        try {
            categoryRepository.deleteById(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public int count() {
        return (int) categoryRepository.count();
    }

    @Override
    public List<Category> findAll(int page, int pagesize) {
        Pageable pageable = PageRequest.of(page, pagesize);
        return categoryRepository.findAll(pageable).getContent();
    }

    @Override
    public Category findByCategoryname(String name) {
        try {
            return categoryRepository.findByCategoryname(name).orElse(null);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}