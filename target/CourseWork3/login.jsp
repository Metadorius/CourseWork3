<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <%@include file="components/head.jsp" %>
    <title>Войти</title>
</head>
<body style="margin:2em auto; max-width:200px; padding:1em; text-align:justify">
<h4>Войти</h4>
<%@include file="components/alert.jsp" %>
<form action="login" method="POST">
    <div class="form-group">
    <input type="text" class="form-control" name="login" placeholder="Логин">
    </div>
    <div class="form-group">
    <input type="password" class="form-control" name="pw" placeholder="Пароль">
    </div>
    <div class="form-group">
    <button type="submit" class="btn btn-outline-primary">Войти</button>
    </div>
</form>
<%@include file="components/tail.jsp" %></body>
</html>
