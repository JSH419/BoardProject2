<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
    <title>게시판 리스트</title>
    <style type="text/css">
   	 body {
       display: flex;
       justify-content: center;
       align-items: center;
       height: 100vh;
       margin: 0;
   			}
   	</style>
</head>
<script>
 $(document).ready(function() {
	 // 삭제 버튼 누를 시 
	 $(function(){
			$("#delBtn").click(function(){
				$("#listFrm").attr("action","delete").attr("method","post").submit();
			})
		})	
 });        
</script>
<body>
<div>
	<input type = "button" name = "writeBtn" id = "writeBtn" value = "글쓰기" onclick = "location.href='write'">
	<input type = "button" name = "delBtn" id = "delBtn" value = "삭제">
</div>

<form name = "listFrm" id = "listFrm">
<table border = "1">
			<thead>
				<tr>	
					<th><input type = "checkbox" name = "all"></th>
					<th>글번호</th>
					<th>작성자(ID)</th>
					<th>제목</th>
					<th>작성일</th>
					<th>수정일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody id = "tableBody">
				<c:forEach items="${list }" var = "boardList" varStatus="loop" begin="0" end="9">
					<tr id = "trList"> 
						<td><input type = "checkbox" name = "chk" value = "${boardList.seq}"></td>
						<td>${boardList.seq }</td>
						<td>${boardList.memName }(${boardList.memId })</td>
						<td><a href = "detail?seq=${boardList.seq }">${boardList.boardSubject }</a></td>
						<td><fmt:formatDate value="${boardList.REG_DATE }" pattern="yyyy-MM-dd"/> </td>
						<td><fmt:formatDate value="${boardList.UPT_DATE }" pattern="yyyy-MM-dd"/></td>
						<td>${boardList.VIEW_CNT }</td>
					</tr>
				</c:forEach>
			</tbody>
	</table>
</form>
</body>
</html>