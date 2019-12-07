<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="navbar navbar-expand-md navbar-light bg-light">
    <button type="button" id="sidebarCollapse" class="btn btn-info">
        <i class="fas fa-align-left"></i>
        <span>Расчёт</span>
    </button>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">
        <ul class="navbar-nav mr-auto">
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" id="checkRadii" checked="checked">
                <label class="form-check-label" for="checkRadii">Радиусы поражения</label>
            </div>
        </ul>
        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <a class="btn btn-outline-primary" href="login" role="button">Управление</a>
            </li>
        </ul>
    </div>
</nav>
