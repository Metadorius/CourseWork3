package db;

import model.AARadius;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import java.util.List;

public class RadiusQueries {
    private static EntityManagerFactory emf = null; // Создание фабрики - тяжеловесный процесс, потому здесь синглтон

    private static EntityManagerFactory getEmf() {
        if (emf == null)
            emf = Persistence.createEntityManagerFactory("DivisionsDB");
        return emf;
    }

    public static List<AARadius> selectAll() {

        EntityManager em = getEmf().createEntityManager(); // а вот менеджер сущностей лёгок в создании, потому каждый раз создаём новый

        Query query = em.
                createQuery("SELECT d FROM AARadius d");
        List<AARadius> resultList = query.getResultList();

        em.close();
        return resultList;
    }

    public static List<AARadius> selectBySystem(int system_id) {

        EntityManager em = getEmf().createEntityManager(); // а вот менеджер сущностей лёгок в создании, потому каждый раз создаём новый
        Query query = em.
                createQuery("SELECT d FROM AARadius d WHERE d.AASystem.id = ?1");
        List<AARadius> resultList = query.setParameter(1, system_id).getResultList();

        em.close();
        return resultList;
    }

    public static void add(AARadius AARadius) {
        EntityManager em = getEmf().createEntityManager();
        em.getTransaction().begin(); // вне зависимости от автокоммитов нужно писать транзакции
        em.persist(AARadius);
        em.getTransaction().commit();
        em.close();
    }

    public static void update(AARadius AARadius) {
        EntityManager em = getEmf().createEntityManager();
        em.getTransaction().begin();

        /* когда мы закрываем конкретный объект EntityManager, все наши сущности (записи),
        полученные при работе с ним, становятся "отсоединенными". AARadius - "отсоединенная",
        т.к. до этого мы нашли её через em.find(...) и закрыли менеджер, а em.merge(AARadius)
        "подсоединяет" сущность обратно */
        em.merge(AARadius);
        em.getTransaction().commit();
        em.close();
    }

    public static void delete(int id) {
        EntityManager em = getEmf().createEntityManager();
        em.getTransaction().begin();
        AARadius AARadius = em.find(AARadius.class, id);
        em.remove(AARadius);
        em.getTransaction().commit();
        em.close();
    }

    public static AARadius get(int id) {
        EntityManager em = getEmf().createEntityManager();
        AARadius AARadius = em.find(AARadius.class, id);
        em.close();
        return AARadius;
    }
}
