<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="navbar navbar-expand-md navbar-dark bg-dark">
    <a class="navbar-brand" href="#">Зоны покрытия ЗРК</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">
        <ul class="navbar-nav mr-auto">
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" id="checkLow" checked="checked">
                <label class="form-check-label" for="checkLow">Нижняя зона</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" id="checkMed" checked="checked">
                <label class="form-check-label" for="checkMed">Средняя зона</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" id="checkHigh" checked="checked">
                <label class="form-check-label" for="checkHigh">Верхняя зона</label>
            </div>
        </ul>
        <a class="btn btn-outline-primary" href="login" role="button">Управление</a>
    </div>
</nav>