<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

    <title>Удалить дивизион</title>
</head>
<body style="margin:2em auto; max-width:800px; padding:1em; text-align:justify">
<h4>Удалить дивизион</h4>

    <p>Для подтверждения введите название дивизиона (<b><c:out value="${division.getName()}"/></b>)</p>
    <c:if test="${!empty message}">
    <div class="alert alert-warning" role="alert">
        <c:out value="${message}"/>
    </div>
    </c:if>
    <form method="POST">
        <div class="form-group">
            <input type="hidden" name="id" value="<c:out value="${division.getId()}"/>">
            <input type="text" class="form-control" name="name" placeholder="Дивизион" required>
        </div>
        <div class="form-group">
            <button type="submit" class="btn btn-outline-primary">Удалить</button>
            <a href="divisionList" class="btn btn-outline-primary">Отмена</a>
        </div>
    </form>



<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>