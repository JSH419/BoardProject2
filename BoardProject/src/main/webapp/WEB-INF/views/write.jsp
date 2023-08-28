<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script>
	$(function(){
		
		$("#regBtn").click(function(){
			$("#frm").attr("action","insert").attr("method","post").submit();
		})
	
		$("#uptBtn").click(function(){
			$("#frm").attr("action","update").attr("method","post").submit();
		})
	})
</script>
<style>
   	 body {
       display: flex;
       justify-content: center;
       align-items: center;
       height: 100vh;
       margin: 0;
   			}
</style>
</head>
<body>
	<form name = "frm" id = "frm">
		<input type = "hidden" name = "seq" id = "seq" value = "${detail.seq}"><br>
		작성자 : <input type = "text" name = "name" id = "name" value = "${detail.name}"><br> 
		아이디 : <input type = "text" name = "id" id = "id" value = "${detail.id}"><br>
		제목 : <input type = "text" name = "subject" id = "subject" value = "${detail.subject}"><br>
		내용 : <br>
		<textarea rows="10" cols="40" name = "content" id = "content">${detail.content}</textarea>
		<br>
		
		<c:if test="${empty detail }">
			<input type = "button" name = "regBtn" id = "regBtn" value = "등록">
		</c:if>
		<c:if test="${not empty detail }">
			<input type = "button" name = "uptBtn" id = "uptBtn" value = "수정">
		</c:if>
	</form>
</body>
</html>