<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="l" uri="http://kwonnam.pe.kr/jsp/template-inheritance"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<l:extends name="/layouts/base.jsp">
    <l:put block="title" type="REPLACE">Добавить дивизион</l:put>
    <l:put block="pageTitle" type="REPLACE">Добавить дивизион</l:put>
    <l:put block="content" type="REPLACE">
        <form method="POST">
            <div class="form-group">
                <input type="text" class="form-control" name="name" placeholder="Дивизион" required>
                <input type="number" class="form-control" name="lat" min="43" max="53" step="0.00001" placeholder="Широта (43°-53°)"
                       required>
                <input type="number" class="form-control" name="lng" min="21" max="41" step="0.00001" placeholder="Долгота (21°-41°)"
                       required>
                <select class="form-control selectpicker" data-live-search="true" id="choices-system" name="system_id" title="Выберите комплекс..." required>
                    <c:forEach items="${systems}" var="x">
                        <option <c:if test="${x.getId() == param.system_id_filter}">selected</c:if> value="<c:out value="${x.getId()}"/>"><c:out value="${x.getName()}"/></option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <button type="submit" class="btn btn-outline-primary">Добавить</button>
                <a href="list" class="btn btn-outline-primary">Отмена</a>
            </div>
        </form>
    </l:put>
</l:extends>