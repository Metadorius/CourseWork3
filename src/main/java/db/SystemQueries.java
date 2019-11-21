package db;

import model.AASystem;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import java.util.List;

public class SystemQueries {
    private static EntityManagerFactory emf = null; // Создание фабрики - тяжеловесный процесс, потому здесь синглтон

    private static EntityManagerFactory getEmf() {
        if (emf == null)
            emf = Persistence.createEntityManagerFactory("DivisionsDB");
        return emf;
    }

    public static List<AASystem> selectAll() {

        EntityManager em = getEmf().createEntityManager(); // а вот менеджер сущностей лёгок в создании, потому каждый раз создаём новый

//        CriteriaBuilder criteriaBuilder = em.getCriteriaBuilder();
//        CriteriaQuery<AASystem> criteriaQuery = criteriaBuilder.createQuery(AASystem.class);
//        Root<AASystem> root = criteriaQuery.from(AASystem.class);
//        criteriaQuery.select(root);
//        TypedQuery<AASystem> query = em.createQuery(criteriaQuery);
        Query query = em.
                createQuery("SELECT d FROM AASystem d");
        List<AASystem> resultList = query.getResultList();

        em.close();
        return resultList;
    }

    public static void add(AASystem AASystem) {
        EntityManager em = getEmf().createEntityManager();
        em.getTransaction().begin(); // вне зависимости от автокоммитов нужно писать транзакции
        em.persist(AASystem);
        em.getTransaction().commit();
        em.close();
    }

    public static void update(AASystem AASystem) {
        EntityManager em = getEmf().createEntityManager();
        em.getTransaction().begin();

        /* когда мы закрываем конкретный объект EntityManager, все наши сущности (записи),
        полученные при работе с ним, становятся "отсоединенными". AASystem - "отсоединенная",
        т.к. до этого мы нашли её через em.find(...) и закрыли менеджер, а em.merge(AASystem)
        "подсоединяет" сущность обратно */
        em.merge(AASystem);
        em.getTransaction().commit();
        em.close();
    }

    public static void delete(int id) {
        EntityManager em = getEmf().createEntityManager();
        em.getTransaction().begin();
        AASystem AASystem = em.find(AASystem.class, id);
        em.remove(AASystem);
        em.getTransaction().commit();
        em.close();
    }

    public static AASystem get(int id) {
        EntityManager em = getEmf().createEntityManager();
        AASystem AASystem = em.find(AASystem.class, id);
        em.close();
        return AASystem;
    }
}
