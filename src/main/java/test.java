//package net.codejava.hibernate;
//
//import model.Division;
//
//import javax.persistence.EntityManager;
//import javax.persistence.EntityManagerFactory;
//import javax.persistence.Persistence;
//
///**
// * UserDAOTest.java
// * Copyright by CodeJava.net
// */
//public class test {
//
//    public static void main(String[] args) {
//        EntityManagerFactory factory = Persistence.createEntityManagerFactory("DivisionsDB");
//        EntityManager entityManager = factory.createEntityManager();
//
//
//        Division division = new Division();
//        division.setName("123");
//        division.setLat(0);
//        division.setLng(0);
//        division.setType("123");
//
//        entityManager.persist(division);
//        entityManager.close();
//        factory.close();
//    }
//}