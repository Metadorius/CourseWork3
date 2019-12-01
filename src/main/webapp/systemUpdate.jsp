<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="l" uri="http://kwonnam.pe.kr/jsp/template-inheritance"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<l:extends name="/layouts/base.jsp">
    <l:put block="title" type="REPLACE">Редактировать ЗРК</l:put>
    <l:put block="pageTitle" type="REPLACE">Редактировать ЗРК</l:put>
    <l:put block="content" type="REPLACE">
        <form method="POST">
            <div class="form-group">
                <input type="hidden" name="id" value="<c:out value="${system.getId()}"/>">
                <input type="text" class="form-control" name="name" placeholder="Система ПВО" value="<c:out value="${system.getName()}"/>" required>
                <input type="number" class="form-control" name="radiusInnerLow" min="0" placeholder="Внутренний радиус (низ)" value="<c:out value="${system.getRadiusInnerLow()}"/>" required>
                <input type="number" class="form-control" name="radiusOuterLow" min="0" placeholder="Внешний радиус (низ)" value="<c:out value="${system.getRadiusOuterLow()}"/>" required>
                <input type="number" class="form-control" name="radiusInnerMed" min="0" placeholder="Внутренний радиус (сред)" value="<c:out value="${system.getRadiusInnerMed()}"/>" required>
                <input type="number" class="form-control" name="radiusOuterMed" min="0" placeholder="Внешний радиус (сред)" value="<c:out value="${system.getRadiusOuterMed()}"/>" required>
                <input type="number" class="form-control" name="radiusInnerHigh" min="0" placeholder="Внутренний радиус (выс)" value="<c:out value="${system.getRadiusInnerHigh()}"/>" required>
                <input type="number" class="form-control" name="radiusOuterHigh" min="0" placeholder="Внешний радиус (выс)" value="<c:out value="${system.getRadiusOuterHigh()}"/>" required>
            </div>
            <div class="form-group">
                <button type="submit" class="btn btn-outline-primary">Сохранить</button>
                <a href="systemList" class="btn btn-outline-primary">Отмена</a>
            </div>
        </form>
    </l:put>
</l:extends>
