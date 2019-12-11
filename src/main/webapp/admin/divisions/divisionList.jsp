<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="l" uri="http://kwonnam.pe.kr/jsp/template-inheritance" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<l:extends name="/layouts/base.jsp">
    <l:put block="title" type="REPLACE">Дивизионы</l:put>
    <l:put block="pageTitle" type="REPLACE">
        <div class="d-flex">
            <div class="mr-auto p-2">
                Дивизионы
            </div>
            <div class="p-2">
                <a class="btn btn-outline-primary" href="send">Отправить данные</a>
            </div>
        </div>
    </l:put>
    <l:put block="content" type="REPLACE">
        <form method="GET">
            <div class="d-flex">
                <div class="mr-auto p-2">
                    <button type="submit" class="btn btn-outline-primary" formaction="add">Добавить</button>
                </div>
                <div class="p-2">
                    <select class="form-control selectpicker" data-live-search="true" name="system_id_filter"
                            title="Выберите комплекс..." required>
                        <c:forEach items="${systems}" var="x">
                            <option
                                    <c:if test="${x.getId() == param.system_id_filter}">selected</c:if>
                                    value="<c:out value="${x.getId()}"/>">
                                <c:out value="${x.getName()}"/></option>
                        </c:forEach>
                    </select>
                </div>
                <div class="p-2">
                    <button type="submit" class="btn btn-outline-primary">Фильтровать</button>
                </div>
                <div class="p-2">
                    <a class="btn btn-outline-primary" href="list">Cбросить</a>
                </div>
            </div>
        </form>

        <table class="table">
            <thead>
            <tr>
                <th scope="col">Дивизион</th>
                <th scope="col">Широта</th>
                <th scope="col">Долгота</th>
                <th scope="col">ЗРК</th>
                <th scope="col">Действие</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${divisions}" var="x">
                <tr>
                    <td><c:out value="${x.getName()}"/></td>
                    <td><c:out value="${x.getLat()}"/></td>
                    <td><c:out value="${x.getLng()}"/></td>
                    <td><c:out value="${x.getAASystem()}"/></td>
                    <td>
                        <form method="GET">
                            <input type="hidden" name="id" value="<c:out value="${x.getId()}"/>">
                            <button type="submit" class="btn btn-outline-primary" formaction="update">Ред.</button>
                            <button type="submit" class="btn btn-outline-primary" formaction="delete">Уд.</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </l:put>
</l:extends>

