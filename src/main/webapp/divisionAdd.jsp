<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/select2@4.0.12/dist/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/select2@4.0.12/dist/js/select2.min.js"></script>


    <title>Добавить дивизион</title>
</head>
<body style="margin:2em auto; max-width:800px; padding:1em; text-align:justify">
<h4>Добавить дивизион</h4>

    <c:if test="${!empty message}">
    <div class="alert alert-warning" role="alert">
        <c:out value="${message}"/>
    </div>
    </c:if>
    <form method="POST">
        <div class="form-group">
            <input type="text" class="form-control" name="name" placeholder="Дивизион" required>
            <input type="number" class="form-control" name="lat" min="-90" max="90" step="0.00001" placeholder="Широта" required>
            <input type="number" class="form-control" name="lng" min="-180" max="180" step="0.00001" placeholder="Долгота" required>
            <select class="select2-selector form-control" name="system_id">
                <c:forEach items="${systems}" var = "x" >
                <option value="<c:out value="${x.getId()}"/>"><c:out value="${x.getName()}"/></option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group">
            <button type="submit" class="btn btn-outline-primary">Добавить</button>
            <a href="divisionList" class="btn btn-outline-primary">Отмена</a>
        </div>
    </form>

<script>
    $(document).ready(function() {
        $('.select2-selector').select2("val", null);
    });
</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

</body>
</html>