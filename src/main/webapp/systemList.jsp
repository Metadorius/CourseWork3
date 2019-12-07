<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="l" uri="http://kwonnam.pe.kr/jsp/template-inheritance"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<l:extends name="/layouts/base.jsp">
    <l:put block="title" type="REPLACE">Зенитно-ракетные комплексы</l:put>
    <l:put block="pageTitle" type="REPLACE">Зенитно-ракетные комплексы</l:put>
    <l:put block="content" type="REPLACE">
        <a class="btn btn-outline-primary" href="systemAdd">Добавить</a>
        <table class="table">
            <thead>
            <tr>
                <th scope="col">ЗРК</th>
                <th scope="col">Скорость полёта ракеты (м/с)</th>
                <th scope="col">Действие</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${systems}" var = "system" >
                <tr>
                    <td><c:out value="${system.getName()}"/></td>
                    <td><c:out value="${system.getRocketSpeed()}"/></td>
                    <td>
                        <form method="GET">
                            <input type="hidden" name="id" value="<c:out value="${system.getId()}"/>">
                            <button type="submit" class="btn btn-outline-primary" formaction="systemUpdate">Ред.</button>
                            <button type="submit" class="btn btn-outline-primary" formaction="systemDelete">Уд.</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </l:put>
</l:extends>
