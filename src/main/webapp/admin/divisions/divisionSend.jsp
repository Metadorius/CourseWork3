<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="l" uri="http://kwonnam.pe.kr/jsp/template-inheritance" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<l:extends name="/layouts/base.jsp">
    <l:put block="title" type="REPLACE">Отправить данные о дивизионах</l:put>
    <l:put block="pageTitle" type="REPLACE">Отправить данные о дивизионах</l:put>
    <l:put block="content" type="REPLACE">
        <form method="POST">
            <div class="form-group">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Логин" name="mail_username">
                    <div class="input-group-addon">
                        <span class="input-group-text">@<c:out value="${postfix}"/></span>
                    </div>
                </div>
                <input type="password" class="form-control" name="mail_password" placeholder="Пароль">
                <input type="email" class="form-control" name="receiver" placeholder="Получатель">
            </div>
            <div class="form-group">
                <button type="submit" class="btn btn-outline-primary">Отправить</button>
                <a href="list" class="btn btn-outline-primary">Отмена</a>
            </div>
        </form>
    </l:put>
</l:extends>