<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">
    <link rel="stylesheet" href="<c:url value='/resources/css/menu.css' />" />
    <title>Board Master</title>
</head>
<body>
    <div id="menu">
    	<ul>
    		<li id="logo">Board</li>
    		<li><a href="<c:url value='/' />">Home</a></li>
    		<li><a href="<c:url value='/list' />">Board</a></li>
    		<!-- <li><a href="<c:url value='/upload' />">uploadForm</a></li> -->
    	</ul>
    </div>
    <div style="text-align: center;">
    	<h1>게시판 마스터하기</h1>
    </div>
</body>
</html>































