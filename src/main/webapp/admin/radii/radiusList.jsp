<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="l" uri="http://kwonnam.pe.kr/jsp/template-inheritance"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<l:extends name="/layouts/base.jsp">
    <l:put block="title" type="REPLACE">Радиусы поражения ЗРК</l:put>
    <l:put block="pageTitle" type="REPLACE">Радиусы поражения ЗРК</l:put>
    <l:put block="content" type="REPLACE">
        <form method="GET">
            <button type="submit" class="btn btn-outline-primary" formaction="add">Добавить</button>
            <c:if test="${!empty param.system_id_filter}">
                <input type="hidden" name="system_id_filter" value="<c:out value="${param.system_id_filter}"/>">
            </c:if>
        </form>
        <form method="GET">
            <select class="form-control selectpicker" data-live-search="true" name="system_id_filter" title="Выберите комплекс..." required>
                <c:forEach items="${systems}" var="x">
                    <option <c:if test="${x.getId() == param.system_id_filter}">selected</c:if> value="<c:out value="${x.getId()}"/>">
                        <c:out value="${x.getName()}"/></option>
                </c:forEach>
            </select>
            <button type="submit" class="btn btn-outline-primary">Фильтровать</button>
            <a class="btn btn-outline-primary" href="list">Cбросить</a>
        </form>

        <table class="table">
            <thead>
            <tr>
                <th scope="col">ЗРК</th>
                <th scope="col">Высота (км)</th>
                <th scope="col">Мин. радиус (км)</th>
                <th scope="col">Макс. радиус (км)</th>
                <th scope="col">Действие</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${radii}" var="x">
                <tr>
                    <td><c:out value="${x.getAASystem()}"/></td>
                    <td><c:out value="${x.getHeight()}"/></td>
                    <td><c:out value="${x.getRadiusInner()}"/></td>
                    <td><c:out value="${x.getRadiusOuter()}"/></td>
                    <td>
                        <form method="GET">
                            <input type="hidden" name="id" value="<c:out value="${x.getId()}"/>">
                            <button type="submit" class="btn btn-outline-primary" formaction="update">Ред.</button>
                            <input type="submit" class="btn btn-outline-primary" formmethod="post" onclick="return confirm('Удалить данную запись?')" value="Уд.">
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </l:put>
</l:extends>

