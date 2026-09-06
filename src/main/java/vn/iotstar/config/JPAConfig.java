package vn.iotstar.config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.PersistenceContext;

public class JPAConfig {
    public static EntityManager getEntityManager() {
        // Tên này PHẢI khớp với <persistence-unit name="..."> trong file persistence.xml
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("jpa-hibernate-sqlserver");
        return factory.createEntityManager();
    }
}