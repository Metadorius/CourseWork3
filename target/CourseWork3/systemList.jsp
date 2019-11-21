<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

    <title>Системы ПВО</title>
</head>
<body style="margin:2em auto; max-width:800px; padding:1em; text-align:justify">
<h4>Системы ПВО</h4>
    <a class="btn btn-outline-primary" href="systemAdd">Добавить</a>
<table class="table">
    <thead>
    <tr>
        <th scope="col">Система ПВО</th>
        <th scope="col">РВН1</th>
        <th scope="col">РВШ1</th>
        <th scope="col">РВН2</th>
        <th scope="col">РВШ2</th>
        <th scope="col">РВН3</th>
        <th scope="col">РВШ3</th>
        <th scope="col">Действие</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${systems}" var = "system" >
    <tr>
        <td><c:out value="${system.getName()}"/></td>
        <td><c:out value="${system.getRadiusInnerLow()}"/></td>
        <td><c:out value="${system.getRadiusOuterLow()}"/></td>
        <td><c:out value="${system.getRadiusInnerMed()}"/></td>
        <td><c:out value="${system.getRadiusOuterMed()}"/></td>
        <td><c:out value="${system.getRadiusInnerHigh()}"/></td>
        <td><c:out value="${system.getRadiusOuterHigh()}"/></td>
        <td>
            <form method="GET">
                <input type="hidden" name="id" value="<c:out value="${system.getId()}"/>">
                <button type="submit" class="btn btn-outline-primary" formaction="systemUpdate">Ред.</button>
                <button type="submit" class="btn btn-outline-primary" formaction="systemDelete">Уд.</button>
            </form>
        </td>
    </tr>
    </c:forEach>
    </tbody>
</table>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>