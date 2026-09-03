package vn.iotstar.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JpaConfig;
import vn.iotstar.model.User;

public class UserDaoImpl {

    public User findById(int id) {
        EntityManager em = JpaConfig.getEntityManager();
        try {
            return em.find(User.class, id);
        } finally {
            em.close();
        }
    }

    public void update(User user) {
        EntityManager em = JpaConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(user);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void insertRegister(User user) {
        EntityManager em = JpaConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(user);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public User findByUsernameOrEmail(String keyword) {
        EntityManager em = JpaConfig.getEntityManager();
        try {
            String jpql = "SELECT u FROM User u WHERE u.username = :kw OR u.email = :kw";
            TypedQuery<User> query = em.createQuery(jpql, User.class);
            query.setParameter("kw", keyword);
            return query.getResultStream().findFirst().orElse(null);
        } finally {
            em.close();
        }
    }

    public User login(String usernameOrEmail, String password) {
        User user = findByUsernameOrEmail(usernameOrEmail);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }
}