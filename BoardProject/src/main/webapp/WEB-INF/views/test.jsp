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
		
		var tmp=0;
		$("#fileAdd").click(function(){
			var file = "<input type=file name=file"+tmp+" id=file"+tmp+"><input type=button id=delBtn"+tmp+" value=삭제 onclick=fncDelete(this)><br>";
			$("#fileDv").append(file);
			
// 			.text()
// 			.html()
// 			.append()
			
			tmp++;
		})
		
	})
	
	
	function fncDelete(delBtn){
		$(delBtn).prev().remove();
		$(delBtn).next().remove();
		$(delBtn).remove();
	}
</script>
</head>
<body>
	<form name = "frm" id = "frm" enctype="multipart/form-data">
		작성자 : <input type = "text" name = "memName" id = "memName" value = "${detail.memName }"><br> 
		아이디 : <input type = "text" name = "memId" id = "memId" value = "${detail.memId }"><br>
		제목 : <input type = "text" name = "subject" id = "subject" value = "${detail.boardSubject }"><br>
		내용 : <br>
		<textarea rows="10" cols="40" name = "content" id = "content">${detail.boardContent }</textarea>
		<br>
		
		<c:if test="${empty detail }">
			<div id = "fileDv">
				<input type = "button" name = "fileAdd" id = "fileAdd" value = "파일추가"><br>
			</div>
			<input type = "button" name = "regBtn" id = "regBtn" value = "등록">
		</c:if>
		<c:if test="${not empty detail }">
			<input type = "button" name = "uptBtn" id = "uptBtn" value = "수정">
		</c:if>
	</form>
</body>
</html>

