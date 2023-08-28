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
		   			
		.container {
	        text-align: center;
	    }
		
	    .button-container {
	    	text-align:right;
	        margin-top: 40px; /* 버튼과 테이블 간의 간격 조절 */
	    }
		
	    .button-container input[type="button"] {
	        margin-right: 20px; /* 버튼 사이의 간격 조절 */
	    }
	    /* 페이징 */
	    .paging-container {
			width: 100%;
			height: 70px;
			display: flex;
			margin-top: 50px;
			margin: auto;
		}
		
		.paging {
			color: black;
			width: 100%;
			align-items: center;
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
<div class="container">
<select class="search-option" name="option" >
	<option value="A" ${pr.sc.option=='A' || pr.sc.option=='' ? "selected" : "" }>선택</option>
	<option value="B" ${pr.sc.option=='B' || pr.sc.option=='' ? "selected" : "" }>제목</option>
	<option value="C" ${pr.sc.option=='C' ? "selected" : "" }>제목+내용</option>
	<option value="D" ${pr.sc.option=='D' ? "selected" : "" }>작성자</option>
</select>
<input type="text" name="keyword" class="search-input" 
		value="${param.keyword }" placeholder="검색어를 입력해주세요"/>
</br>
<!-- 날짜 선택란 -->
<label for="startDate">시작일:</label>
<input type="date" id="startDate" name="startDate">

<label for="endDate">종료일:</label>
<input type="date" id="endDate" name="endDate">
		
<input type="submit" value="검색" class="search-button"/>

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