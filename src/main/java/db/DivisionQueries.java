package db;

import model.Division;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;

public class DivisionQueries {
    private static EntityManagerFactory emf = null; // Создание фабрики - тяжеловесный процесс, потому здесь синглтон

    private static EntityManagerFactory getEmf() {
        if (emf == null)
            emf = Persistence.createEntityManagerFactory("DivisionsDB");
        return emf;
    }

    public static List<Division> selectAll() {

        EntityManager em = getEmf().createEntityManager(); // а вот менеджер сущностей лёгок в создании, потому каждый раз создаём новый

        CriteriaBuilder criteriaBuilder = em.getCriteriaBuilder();
        CriteriaQuery<Division> criteriaQuery = criteriaBuilder.createQuery(Division.class);
        Root<Division> root = criteriaQuery.from(Division.class);
        criteriaQuery.select(root);
        TypedQuery<Division> query = em.createQuery(criteriaQuery);
        List<Division> resultList = query.getResultList();

        em.close();
        return resultList;
    }

    public static void add(Division division) {
        EntityManager em = getEmf().createEntityManager();
        em.getTransaction().begin(); // вне зависимости от автокоммитов нужно писать транзакции
        em.persist(division);
        em.getTransaction().commit();
        em.close();
    }

    public static void update(Division division) {
        EntityManager em = getEmf().createEntityManager();
        em.getTransaction().begin();

        /* когда мы закрываем конкретный объект EntityManager, все наши сущности (записи),
        полученные при работе с ним, становятся "отсоединенными". division - "отсоединенная",
        т.к. до этого мы нашли её через em.find(...) и закрыли менеджер, а em.merge(division)
        "подсоединяет" сущность обратно */
        em.merge(division);
        em.getTransaction().commit();
        em.close();
    }

    public static void delete(int id) {
        EntityManager em = getEmf().createEntityManager();
        em.getTransaction().begin();
        Division division = em.find(Division.class, id);
        em.remove(division);
        em.getTransaction().commit();
        em.close();
    }

    public static Division get(int id) {
        EntityManager em = getEmf().createEntityManager();
        Division division = em.find(Division.class, id);
        em.close();
        return division;
    }
}
