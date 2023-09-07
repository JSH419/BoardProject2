<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- 파일 업로드 --> 
<form action="upload_ok1" method="post" enctype="multipart/form-data">
	파일 선택 : <input type="file" name="file">
	<input type="submit" value="전송">
</form>

<!-- 파일 두개이상 -->
<form action="upload_ok2" method="post" enctype="multipart/form-data">
	파일 선택 : <input type="file" multiple="multiple" name="files">
			 <input type="file" multiple="multiple" name="files"> 
			 <input type="file" multiple="multiple" name="files"> 
			 <input type="submit" value="전송">
</form>
</body>
</html>