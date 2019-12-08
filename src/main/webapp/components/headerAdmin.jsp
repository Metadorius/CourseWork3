<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="navbar navbar-expand-md navbar-dark bg-dark">
    <a class="navbar-brand" href="#">Зоны покрытия ЗРК</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" href="<c:url value = "/admin/divisions/list"/>">Дивизионы</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<c:url value = "/admin/systems/list"/>">ЗРК</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<c:url value = "/admin/radii/list"/>">Радиусы</a>
            </li>
        </ul>
        <a class="btn btn-outline-primary" href="<c:url value = "/"/>" role="button">Вернуться к карте</a>
    </div>
</nav>