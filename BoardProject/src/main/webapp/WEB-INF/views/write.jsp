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
		
		var tmp=0;
		$("#fileAdd").click(function(){
			var file = "<input type=file name=file"+tmp+" id=file"+tmp+" onchange=checkFile(this)><input type=button id=delBtn"+tmp+" value='X' onclick=fncDelete(this)><br>";
			$("#fileDv").append(file);

			tmp++;
		})

	})
	// 삭제 버튼 클릭시 이전, 후 태그 삭제 
	function fncDelete(delBtn){
		$(delBtn).prev().remove();
		$(delBtn).next().remove();
		$(delBtn).remove();
	}
	
	// 이미지 픽셀(500*500) 체크 
	function checkFile(el) {
		
	    var file = el.files;
	    var reader = new FileReader();
	
	    // 파일 읽기가 완료되면 실행되는 이벤트 핸들러
	    reader.onload = function (e) {
	        var img = new Image();
	        img.src = e.target.result;
	
	        img.onload = function () {
	            // 이미지의 가로와 세로 차원을 검사
	            var maxWidth = 500;
	            var maxHeight = 500;
	
	            if (img.width > maxWidth || img.height > maxHeight) {
	                // 차원 초과시 경고후 해당 이미지의 차원도 보여줌
	                alert('이미지 차원은 500x500 픽셀 이하여야 합니다.\n\n' + '현재 이미지 차원: ' + img.width + 'x' + img.height + ' 픽셀');
	                el.value = ''; // 파일 입력 필드 초기화
	            }
	        };
	    };
	
	    if (file.length > 0) {
	        // 파일 읽기 시작
	        reader.readAsDataURL(file[0]);
	    }
	}
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
	<form name = "frm" id = "frm" enctype="multipart/form-data"> 
		<input type = "hidden" name = "seq" id = "seq" value = "${detail.seq}"><br>
		작성자 : <input type = "text" name = "name" id = "name" value = "${detail.name}"><br> 
		아이디 : <input type = "text" name = "id" id = "id" value = "${detail.id}"><br>
		제목 : <input type = "text" name = "subject" id = "subject" value = "${detail.subject}"><br>
		내용 : <br>
		<textarea rows="10" cols="40" name = "content" id = "content">${detail.content}</textarea>
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