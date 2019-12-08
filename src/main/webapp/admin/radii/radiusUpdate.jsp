<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="l" uri="http://kwonnam.pe.kr/jsp/template-inheritance"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<l:extends name="/layouts/base.jsp">
    <l:put block="title" type="REPLACE">Редактировать радиус</l:put>
    <l:put block="pageTitle" type="REPLACE">Редактировать радиус</l:put>
    <l:put block="content" type="REPLACE">
        <form method="POST">
            <div class="form-group">
                <input type="hidden" name="id" value="<c:out value="${radius.getId()}"/>">
                <select class="form-control selectpicker" data-live-search="true" id="choices-system" name="system_id" title="Выберите комплекс..." required>
                    <c:forEach items="${systems}" var="x">
                        <option <c:if test="${x.getId() == radius.getAASystem().getId()}">selected</c:if> value="<c:out value="${x.getId()}"/>"><c:out value="${x.getName()}"/></option>
                    </c:forEach>
                </select>
                <input type="number" class="form-control" name="height" min="0" step="any" placeholder="Высота (км)"
                       value="<c:out value="${radius.getHeight()}"/>" required>
                <input type="number" class="form-control" name="radiusInner" min="0" step="any" placeholder="Мин. радиус (км)"
                        value="<c:out value="${radius.getRadiusInner()}"/>" required>
                <input type="number" class="form-control" name="radiusOuter" min="0" step="any" placeholder="Макс. радиус (км)"
                       value="<c:out value="${radius.getRadiusOuter()}"/>" required>
            </div>
            <div class="form-group">
                <button type="submit" class="btn btn-outline-primary">Сохранить</button>
                <a href="list" class="btn btn-outline-primary">Отмена</a>
            </div>
        </form>
    </l:put>
</l:extends>