<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    response.setHeader("Content-Disposition","attachment;filename=board.xls");    //디폴트 파일명 지정
    response.setHeader("Content-Description", "JSP Generated Data"); 
%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script  src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script>
	$(function(){
		
		$("#searchType").val('${paramMap.searchType}');
		$("#keyword").val('${paramMap.keyword}');
		
		$("#searchBtn").click(function(){
			
			//$("#searchFrm").attr("action","list").attr("method","post").submit();
 			$.ajax({
 				url : "searchList",
 				data : $("#searchFrm").serialize(),
				type : "post",
				
 				success : function(search){
					
 					console.log(search);
 					$("#listFrm").html(search);
 				},
 				error: function(xhr, status, error) {
			        // 에러 시 처리
			        console.error('에러 발생:', status, error);
			        // xhr.status에는 HTTP 상태 코드가 포함되어 있음
			        console.log('HTTP 상태 코드:', xhr.status);
			        // xhr.responseText에는 서버로부터 받은 응답 데이터 또는 에러 메시지가 포함되어 있음
			        console.log('에러 응답:', xhr.responseText);
			    }			
 			})
		})		
		$("#delBtn").click(function(){
			$("#listFrm").attr("action","delete").attr("method","post").submit();
			
		})
		$("#exceldown").click(function(){
			$("#listFrm").attr("action","exceldown").attr("method","post").submit();
		})
	})
	
	function list(num){
		$("#pageNo").val(num);
		$("#searchBtn").click();
	}
</script>
</head>
<body>

<form name = "searchFrm" id = "searchFrm">
	<input type = "hidden" name = "pageNo" id = "pageNo" value = "1">
	<input type = "hidden" name = "listSize" id = "listSize" value = "10">
		
	<div>
		<select name = "searchType" id = "searchType">
			<option value = "sel" >선택</option>
			<option value = "name">작성자</option>
			<option value = "subject">제목</option>
			<option value = "content">제목+내용</option>
		</select>
		<input type = "text" name = "keyword" id = "keyword">
		<input type = "button" name = "searchBtn" id = "searchBtn" value = "검색"><br>
		<input type = "date" name = "stDate" id = "stDate"> ~ <input type = "date" name = "endDate" id = "endDate">
	</div>
</form>
<div>
	<input type = "button" name = "writeBtn" id = "writeBtn" value = "글쓰기" onclick = "location.href='write'">
	<input type = "button" name = "delBtn" id = "delBtn" value = "삭제">
	<input type = "button" name = "exceldown" id = "exceldown" value = "엑셀다운로드"> 
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
				<c:forEach items="${list }" var = "boardList" varStatus="num">
					<tr id = "trList">
						<td><input type = "checkbox" name = "chk" value = "${boardList.seq }"></td>
						<td>${boardList.seq }</td>
						<td>${boardList.name }(${boardList.id })</td>
						<td><a href = "detail?seq=${boardList.seq }">${boardList.subject }</a></td>
						<td><fmt:formatDate value="${boardList.regDate }" pattern="yyyy-MM-dd"/> </td>
						<td><fmt:formatDate value="${boardList.uptDate }" pattern="yyyy-MM-dd"/></td>
						<td>${boardList.viewCnt }</td>
					</tr>
				</c:forEach>
				
			<tr>
	            <td colspan="7">
	                <!-- **처음페이지로 이동 : 현재 페이지가 1보다 크면  [처음]하이퍼링크를 화면에 출력-->
	                <c:if test="${pageVO.curBlock > 1}">
	                    <a href="javascript:list('1')">[처음]</a>
	                </c:if>
	                
	                <!-- **이전페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 [이전]하이퍼링크를 화면에 출력 -->
	                <c:if test="${pageVO.curBlock > 1}">
	                    <a href="javascript:list('${pageVO.prevPage}')">[이전]</a>
	                </c:if>
	                
	                <!-- **하나의 블럭에서 반복문 수행 시작페이지부터 끝페이지까지 -->
	                <c:forEach var="num" begin="${pageVO.blockBegin}" end="${pageVO.blockEnd}">
	                    <!-- **현재페이지이면 하이퍼링크 제거 -->
	                    <c:choose>
	                        <c:when test="${num == pageVO.curPage}">
	                            <span style="color: red">${num}</span>&nbsp;
	                        </c:when>
	                        <c:otherwise>
	                            <a href="javascript:list('${num}')">${num}</a>&nbsp;
	                        </c:otherwise>
	                    </c:choose>
	                </c:forEach>
	                
	                <!-- **다음페이지 블록으로 이동 : 현재 페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 [다음]하이퍼링크를 화면에 출력 -->
	                <c:if test="${pageVO.curBlock <= pageVO.totBlock}">
	                    <a href="javascript:list('${pageVO.nextPage}')">[다음]</a>
	                </c:if>
	                
	                <!-- **끝페이지로 이동 : 현재 페이지가 전체 페이지보다 작거나 같으면 [끝]하이퍼링크를 화면에 출력 -->
	                <c:if test="${pageVO.curPage <= pageVO.totPage}">
	                    <a href="javascript:list('${pageVO.totPage}')">[끝]</a>
	                </c:if>
	            </td>
        </tr>
	</tbody>
</table>
</form>
</body>
</html>