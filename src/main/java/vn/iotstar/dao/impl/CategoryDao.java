package vn.iotstar.dao.impl;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JpaConfig;
import vn.iotstar.dao.ICategoryDao;
import vn.iotstar.entity.Category;

public class CategoryDao implements ICategoryDao {

    @Override
    public void insert(Category category) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.persist(category);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void update(Category category) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.merge(category);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void delete(int cateid) throws Exception {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            Category category = enma.find(Category.class, cateid);
            if (category != null) {
                enma.remove(category);
            } else {
                throw new Exception("Không tìm thấy");
            }
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public Category findById(int cateid) {
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            return enma.find(Category.class, cateid);
        } finally {
            enma.close();
        }
    }

    @Override
    public Category findByCategoryname(String name) throws Exception {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT c FROM Category c WHERE c.categoryname = :catename";
        try {
            TypedQuery<Category> query = enma.createQuery(jpql, Category.class);
            query.setParameter("catename", name);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            enma.close();
        }
    }

    @Override
    public List<Category> findAll() {
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            TypedQuery<Category> query = enma.createNamedQuery("Category.findAll", Category.class);
            return query.getResultList();
        } finally {
            enma.close();
        }
    }

    @Override
    public List<Category> searchByName(String catname) {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT c FROM Category c WHERE c.categoryname LIKE :catname";
        try {
            TypedQuery<Category> query = enma.createQuery(jpql, Category.class);
            query.setParameter("catname", "%" + catname + "%");
            return query.getResultList();
        } finally {
            enma.close();
        }
    }

    @Override
    public List<Category> findAll(int page, int pagesize) {
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            TypedQuery<Category> query = enma.createNamedQuery("Category.findAll", Category.class);
            query.setFirstResult(page * pagesize);
            query.setMaxResults(pagesize);
            return query.getResultList();
        } finally {
            enma.close();
        }
    }

    @Override
    public int count() {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT COUNT(c) FROM Category c";
        try {
            Query query = enma.createQuery(jpql);
            return ((Long) query.getSingleResult()).intValue();
        } finally {
            enma.close();
        }
    }
}