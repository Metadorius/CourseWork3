<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav id="sidebar" class="p-4">
    <ul class="list-unstyled components">
        <p>Dummy Heading</p>
        <div>
            <div class="form-group">
                <label for="horizontalDistance">Дистанция (км)</label>
                <input readonly type="text" class="form-control" id="horizontalDistance">
            </div>
            <div class="form-group">
                <label for="height">Высота (км)</label>
                <input type="number" class="form-control" id="height" min="0">
            </div>
            <div class="form-group">
                <label for="heading">Курс (градусы)</label>
                <input type="number" class="form-control" id="heading" min="-180" max="180">
            </div>
            <div class="form-group">
                <label for="speed">Скорость (км/ч)</label>
                <input type="number" class="form-control" id="speed" min="1">
            </div>
            <button class="btn btn-outline-primary" id="calculate">Рассчитать</button>
        </div>
    </ul>
</nav>