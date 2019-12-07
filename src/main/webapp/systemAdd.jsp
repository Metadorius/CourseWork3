<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="l" uri="http://kwonnam.pe.kr/jsp/template-inheritance"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<l:extends name="/layouts/base.jsp">
    <l:put block="title" type="REPLACE">Добавить ЗРК</l:put>
    <l:put block="pageTitle" type="REPLACE">Добавить ЗРК</l:put>
    <l:put block="content" type="REPLACE">
        <form method="POST">
            <div class="form-group">
                <input type="text" class="form-control" name="name" placeholder="ЗРК" required>
                <input type="number" class="form-control" name="rocketSpeed" min="0" step="any" placeholder="Скорость полёта ракеты (м/с)" required>
            </div>
            <div class="form-group">
                <button type="submit" class="btn btn-outline-primary">Добавить</button>
                <a href="systemList" class="btn btn-outline-primary">Отмена</a>
            </div>
        </form>
    </l:put>
</l:extends>