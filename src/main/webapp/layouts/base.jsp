<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="l" uri="http://kwonnam.pe.kr/jsp/template-inheritance" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <%@ include file="../components/head.jsp" %>
    <title><l:block name="title">Данные</l:block></title>
</head>
<body>

<div id="header">
    <l:block name="header">
        <%@ include file="../components/headerAdmin.jsp" %>
    </l:block>
</div>

<div style="margin:2em auto; max-width:800px; padding:1em; text-align:justify">
    <div id="pageTitle">
        <h4><l:block name="pageTitle"/></h4>
    </div>

    <div id="alert">
        <l:block name="tail">
            <%@ include file="../components/alert.jsp" %>
        </l:block>
    </div>

    <div id="content">
        <l:block name="content"/>
    </div>
</div>

<div id="tail">
    <l:block name="tail">
        <%@ include file="../components/tail.jsp" %>
    </l:block>
</div>

</body>
</html>