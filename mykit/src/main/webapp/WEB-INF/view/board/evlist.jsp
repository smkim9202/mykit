<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /WEB-INF/view/board/evlist.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>    
<!DOCTYPE html>
<html><head><meta charset="UTF-8">
<title>공지&이벤트</title>
<link href="../css/board.css" rel="stylesheet">
<script type="text/javascript">
   function listpage(page) {
	   document.searchform.pageNum.value=page;
	   document.searchform.submit();
   }
</script>
</head>
<body>
<h3 id="board-title">공지&이벤트</h3>
<div class="tablewrap">
<table>
	<tr><td colspan="6">
		<div style="dispaly:inline;">
			<form action="evlist" method="post" name="searchform">
			<input type="hidden" name="pageNum" value="1">
			<select name="searchtype" style="width:100px;">
			<option value="">선택하세요</option>
			<option value="title">제목</option>
			<option value="content">내용</option>
			</select>&nbsp;&nbsp;
		    <script>
		       document.searchform.searchtype.value='${param.searchtype}'
		    </script>
			<input type="text" name="searchcontent" value="${param.searchcontent}"
				style="width:250px;">&nbsp;&nbsp;
			<span class="box">
			<input type="submit" value="검색">
			<input type="button" value="전체보기" onclick="location.href='evlist'">
			</span>
			</form>
		</div>
	</td></tr>
	<c:if test="${listcount>0}"><%-- 등록된 게시물이 존재하는 경우 --%>
		<tr><td class="rctd">총 ${listcount}개</td>
			<td colspan="4">&nbsp;</td>
			<td class="rctd">
				<%-- 글쓰기버튼 관리자 로그인시만 보임 --%>
				<c:if test="${sessionScope.loginUser.userid eq 'admin'}">
					<span class="box"><input type="button" value="작성" onclick="location.href='evwrite'"></span></c:if>
				<c:if test="${sessionScope.loginUser.userid ne 'admin'}">
					📢</c:if>
				</td>
		</tr>
		<tr><th>no.</th><th  colspan="4">제목</th><th>date</th></tr>
		<c:forEach var="board" items="${boardlist}">
		<tr><td>${boardno}</td><c:set var="boardno" value="${boardno -1}" />
			<td colspan="4" class="rcleft">
				<%--파일첨부여부 제목 앞에 표시 --%>
				<c:if test="${! empty board.fileurl}"><a href="file/${board.fileurl}">&nbsp;🔗&nbsp;</a></c:if>
				<c:if test="${empty board.fileurl}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</c:if>
				<a href="evdetail?num=${board.num}">${board.title}</a></td>
			<td><fmt:formatDate value="${board.regdate}" pattern="YYYY-MM-dd"/></td>
		</tr>	
	</c:forEach>
		<tr><td colspan="6">
				<c:if test="${pageNum > 1}">
				<a href="javascript:listpage(${pageNum - 1})">◀</a></c:if>
				<c:if test="${pageNum <= 1}">&nbsp;</c:if>
				<c:forEach var="a" begin="${startpage}" end="${endpage}">
				<c:if test="${a == pageNum}"><span class="selectedA">${a}</span></c:if>
				<c:if test="${a != pageNum}">
				<a href="javascript:listpage(${a})">${a}</a></c:if>
				</c:forEach>
				<c:if test="${pageNum < maxpage}"><a href="javascript:listpage(${pageNum + 1})">▶</a></c:if>
				<c:if test="${pageNum >= maxpage}">&nbsp;</c:if></td></tr>
				</c:if>
	<c:if test="${listcount == 0}"><%-- 등록된 게시물이 없는 경우 --%>
			<tr><td colspan="5">등록된 게시물이 없습니다.</td></tr>
			<%-- 글쓰기버튼 관리자 로그인시만 보임 --%>
			<c:if test="${sessionScope.loginUser.userid eq 'admin'}">
			<tr><td><span class="box"><input type="button" value="작성" onclick="location.href='evwrite'"></span></td></tr></c:if>
	</c:if> 
		
</table></div></body></html>