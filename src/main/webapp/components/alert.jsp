<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${!empty message}">
    <div class="alert alert-warning" role="alert">
        <c:out value="${message}"/>
    </div>
</c:if>