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
<!-- 검색창 -->
<form action="list" method="post">
<div class="search">
	<div>
		<select name = "searchType" id = "searchType">
			<option value = "sel">선택</option>
			<option value = "name">작성자</option>
			<option value = "subject">제목</option>
			<option value = "content">제목+내용</option>
		</select>
		<input type = "text" name = "keyword" id = "keyword">
		<input type = "submit" name = "searchBtn" id = "searchBtn" value = "검색"><br>
		<input type = "date" name = "stDate" id = "stDate"> ~ <input type = "date" name = "endDate" id = "endDate">
	</div>
</div>
</form>

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
				<c:forEach items="${list}" var = "boardList" varStatus="num">
					<tr id = "trList"> 
						<td><input type = "checkbox" name = "chk" value = "${boardList.seq}"></td>
						<td>${boardList.seq }</td>
						<td>${boardList.name }(${boardList.id })</td>
						<td><a href = "detail?seq=${boardList.seq }">${boardList.subject }</a></td>
						<td><fmt:formatDate value="${boardList.regDate }" pattern="yyyy-MM-dd"/> </td>
						<td><fmt:formatDate value="${boardList.uptDate }" pattern="yyyy-MM-dd"/></td>
						<td>${boardList.viewCnt }</td>
					</tr>
				</c:forEach>
			</tbody>
	</table>
</form>

<!-- 글쓰게, 삭제 버튼 -->
<div class="button-container">
    <input type="button" name="writeBtn" id="writeBtn" value="글쓰기" onclick="location.href='write'">
    <input type="button" name="delBtn" id="delBtn" value="삭제">
</div>

<!-- 페이징 -->
<div id="outter">
	<div style="display: block; text-align: center;">		
		<c:if test="${paging.startPage != 1 }">
			<a href="/board/list?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}">&lt;</a>
		</c:if>
		<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
			<c:choose>
				<c:when test="${p == paging.nowPage }">
					<b>${p }</b>
				</c:when>
				<c:when test="${p != paging.nowPage }">
					<a href="/board/list?nowPage=${p }&cntPerPage=${paging.cntPerPage}">${p }</a>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.endPage != paging.lastPage}">
			<a href="/board/list?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">&gt;</a>
		</c:if>
	</div>
</div>
</body>
</html>