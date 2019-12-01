<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="l" uri="http://kwonnam.pe.kr/jsp/template-inheritance"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<l:extends name="/layouts/base.jsp">
    <l:put block="title" type="REPLACE">Удалить ЗРК</l:put>
    <l:put block="pageTitle" type="REPLACE">Удалить ЗРК</l:put>
    <l:put block="content" type="REPLACE">
        <c:if test="${!empty system}">
        <p>Для подтверждения введите название системы ПВО (<b><c:out value="${system.getName()}"/></b>)</p>
        </c:if>
        <form method="POST">
            <c:if test="${!empty system}">
            <div class="form-group">
                <input type="hidden" name="id" value="<c:out value="${system.getId()}"/>">
                <input type="text" class="form-control" name="name" placeholder="Система ПВО" required>
            </div>
            </c:if>
            <div class="form-group">
                <c:if test="${!empty system}">
                <button type="submit" class="btn btn-outline-primary">Удалить</button>
                </c:if>
                <a href="systemList" class="btn btn-outline-primary">Отмена</a>
            </div>
        </form>
    </l:put>
</l:extends>
