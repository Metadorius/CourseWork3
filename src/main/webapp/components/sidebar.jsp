<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav id="sidebar" class="bg-light p-4">
    <ul class="list-unstyled components">
        <div>
            <div class="form-group">
                <label for="height">Высота (км)</label>
                <input type="number" class="form-control" id="height" min="0" value="0" step="any">
            </div>
            <div class="form-group">
                <label for="speed">Скорость цели (км/ч)</label>
                <input type="number" class="form-control" id="speed" min="1" value="1200" step="any">
            </div>
            <div class="form-group">
                <label for="rockets">Кол-во ракет</label>
                <input type="number" class="form-control" id="rockets" min="1" value="1" step="1">
            </div>
            <div class="form-group">
                <label for="timeDelta">Интервал (с)</label>
                <input type="number" class="form-control" id="timeDelta" min="1" value="1" step="any">
            </div>
            <div class="p-1"></div>
            <b>Расчёт</b>
            <div class="form-group">
                <label for="horizontalDistance">Дистанция (км)</label>
                <input readonly type="text" class="form-control-plaintext" id="horizontalDistance">
            </div>
            <div class="form-group">
                <label for="heading">Курс (градусы)</label>
                <input readonly type="text" class="form-control-plaintext" id="heading">
            </div>
            <div class="form-group">
                <label for="headingParameter">Курсовой параметр (км)</label>
                <input readonly type="text" class="form-control-plaintext" id="headingParameter">
            </div>
            <div class="form-group">
                <label for="interpolatedRadiusInner">Мин. дистанция поражения (км)</label>
                <input readonly type="text" class="form-control-plaintext" id="interpolatedRadiusInner">
            </div>
            <div class="form-group">
                <label for="interpolatedRadiusOuter">Макс. дистанция поражения (км)</label>
                <input readonly type="text" class="form-control-plaintext" id="interpolatedRadiusOuter">
            </div>
            <div class="form-group">
                <label for="launchDistanceMin">Мин. дистанция пуска (км)</label>
                <input readonly type="text" class="form-control-plaintext" id="launchDistanceMin">
            </div>
            <div class="form-group">
                <label for="launchDistanceMax">Макс. дистанция пуска (км)</label>
                <input readonly type="text" class="form-control-plaintext" id="launchDistanceMax">
            </div>
            <div class="p-5"></div>
        </div>
    </ul>
</nav>