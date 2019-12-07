<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav id="sidebar" class="bg-light p-4">
    <ul class="list-unstyled components">
        <div>
            <div class="form-group">
                <label for="height">Высота (км)</label>
                <input type="number" class="form-control" id="height" min="0" value="0">
            </div>
            <div class="form-group">
                <label for="heading">Курс (градусы)</label>
                <input type="number" class="form-control" id="heading" min="-180" max="180" value="0">
            </div>
            <div class="form-group">
                <label for="speed">Скорость цели (км/ч)</label>
                <input type="number" class="form-control" id="speed" min="1" value="1200">
            </div>
            <div class="form-group">
                <label for="rockets">Кол-во ракет</label>
                <input type="number" class="form-control" id="rockets" min="1" value="1">
            </div>
            <div class="form-group">
                <label for="timeDelta">Интервал между пусками (с)</label>
                <input type="number" class="form-control" id="timeDelta" min="1" value="1">
            </div>

            <button class="btn btn-outline-primary" id="calculate">Рассчитать</button>
            <div class="form-group">
                <label for="horizontalDistance">Дистанция (км)</label>
                <input readonly type="text" class="form-control" id="horizontalDistance">
            </div>
            <div class="form-group">
                <label for="headingParameter">Курсовой параметр (км)</label>
                <input readonly type="text" class="form-control" id="headingParameter">
            </div>
            <div class="form-group">
                <label for="launchDistanceMin">Мин. дистанция пуска (км)</label>
                <input readonly type="text" class="form-control" id="launchDistanceMin">
            </div>
            <div class="form-group">
                <label for="launchDistanceMax">Макс. дистанция пуска (км)</label>
                <input readonly type="text" class="form-control" id="launchDistanceMax">
            </div>
        </div>
    </ul>
</nav>