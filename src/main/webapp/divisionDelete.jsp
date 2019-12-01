<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="l" uri="http://kwonnam.pe.kr/jsp/template-inheritance"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<l:extends name="/layouts/base.jsp">
    <l:put block="title" type="REPLACE">Удалить дивизион</l:put>
    <l:put block="pageTitle" type="REPLACE">Удалить дивизион</l:put>
    <l:put block="content" type="REPLACE">
        <p>Для подтверждения введите название дивизиона (<b><c:out value="${division.getName()}"/></b>)</p>
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
    </l:put>
</l:extends>