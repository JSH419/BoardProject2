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
	     .pagination {
        list-style: none;
        padding: 0;
	    }
	
	    .pagination li {
	        display: inline-block;
	        margin-right: 3px;
	    }
	
	    .pagination a {
	        display: inline-block;
	        padding: 3px 10px;
	        background-color: #ccc;
	        color: #333;
	        text-decoration: none;
	        border: 1px solid #ccc;
	        border-radius: 4px;
	    }
	
	    .pagination .current {
	        background-color: #007bff;
	        color: #fff;
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
 
 function list(num){
	 	$('#curPage').val(num);
	 	$('#searchBtn').click();
 }
</script>
<body>
<!-- 검색창 -->
<form action="list" method="get">
<div class="search">
	<div>
		<input type="hidden" name="curPage" id="curPage" value="1">
		<input type="hidden" name="pageScale" id="pageScale" value="10">
		<select name="searchType" id="searchType">
		    <option value="sel">선택</option>
		    <option value="name" <% if (session.getAttribute("searchType") != null && session.getAttribute("searchType").equals("name")) { %> selected <% } %>>작성자</option>
		    <option value="subject" <% if (session.getAttribute("searchType") != null && session.getAttribute("searchType").equals("subject")) { %> selected <% } %>>제목</option>
		    <option value="content" <% if (session.getAttribute("searchType") != null && session.getAttribute("searchType").equals("content")) { %> selected <% } %>>제목+내용</option>
		</select>
		<input type = "text" name = "keyword" id = "keyword" 
		<% if (session.getAttribute("searchKeyword") != null) { %> 
           value="<%= session.getAttribute("searchKeyword") %>"
        <% } %>> 
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

<div class="pagination">
    <!-- **처음페이지로 이동 -->
    <c:if test="${pageMap.curBlock > 0}">
        <li><a href="javascript:list('1')">처음</a></li>
    </c:if>

    <!-- **이전페이지 블록으로 이동 -->
    <c:if test="${pageMap.curBlock > 1}">
        <li><a href="javascript:list('${pageMap.prevPage}')">이전</a></li>
    </c:if>

    <!-- **하나의 블럭에서 반복문 수행 시작페이지부터 끝페이지까지 -->
    <c:forEach var="num" begin="${pageMap.blockBegin}" end="${pageMap.blockEnd}">
        <!-- **현재 페이지이면 하이퍼링크 제거 -->
        <c:choose>
            <c:when test="${num == pageMap.curPage}">
                <li><span style="color: red">${num}</span></li>
            </c:when>
            <c:otherwise>
                <li><a href="javascript:list('${num}')">${num}</a></li>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <!-- **다음페이지 블록으로 이동 -->
    <c:if test="${pageMap.curBlock <= pageMap.totBlock}">
        <li><a href="javascript:list('${pageMap.nextPage}')">다음</a></li>
    </c:if>

    <!-- **끝페이지로 이동 -->
    <c:if test="${pageMap.curPage <= pageMap.totPage}">
        <li><a href="javascript:list('${pageMap.totPage}')">끝</a></li>
    </c:if>
</div>

<!-- 글쓰기, 삭제 버튼 -->
<div class="button-container">
    <input type="button" name="writeBtn" id="writeBtn" value="글쓰기" onclick="location.href='write'">
    <input type="button" name="delBtn" id="delBtn" value="삭제">
</div>

</body>
</html>