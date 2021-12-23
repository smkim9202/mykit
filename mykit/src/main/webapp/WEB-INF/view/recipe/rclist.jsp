<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /WEB-INF/view/recipe/rclist.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>    
<!DOCTYPE html>
<html><head><meta charset="UTF-8">
<title>밀키트 데뷔전</title>
<link href="../css/board.css" rel="stylesheet">
<script type="text/javascript">
	function listpage(page) {
		document.searchform.pageNum.value=page
		document.searchform.sort.value=document.getElementById('sort').value
		document.searchform.submit()
   	}
   	function sortlist(sort) {
   		document.getElementById('sort').value = sort
		listpage(1)
	}
</script>
</head>
<body>
<h3 id="board-title">밀키트 데뷔전</h3>
<div class="tablewrap">				
<table>
	<tr>
		<td colspan="6">
			<div style="dispaly:inline;">
				<form action="rclist" method="post" name="searchform">
					<input type="hidden" name="pageNum" value="1">
					<input type="hidden" id="sort" name="sort" value="${sort}">
					<select name="searchtype" style="width:100px;">
					<option value="">선택하세요</option>
					<option value="rctitle">제목</option>
					<option value="userid">작성자</option>
					<option value="rccontent">내용</option>
					</select>
				    <script>
				       document.searchform.searchtype.value='${param.searchtype}'
				    </script>&nbsp;&nbsp;
					<input type="text" name="searchcontent" value="${param.searchcontent}"
						style="width:250px;">&nbsp;&nbsp;
					<span class="box">
					<input type="submit" value="검색">
					<input type="button" value="전체보기" onclick="location.href='rclist'">
					</span>
				</form>
			</div>
		</td></tr>
<c:if test="${listcount>0}"><%-- 등록된 게시물이 존재하는 경우 --%>
	<tr><td class="rctd">총 ${listcount}개</td>
		
		<td colspan="3">
		<%--선택된 정렬에 css 주기 --%>
		<c:if test="${sort eq 'recent'}">
			<a href="javascript:sortlist('recent');"><span class="selectedA">최신순</span></a> | 
			<a href="javascript:sortlist('hits');">조회순</a> | 
			<a href="javascript:sortlist('heart')">좋아요순</a>
		</c:if>
		<c:if test="${sort eq 'hits'}">
			<a href="javascript:sortlist('recent');">최신순</a> | 
			<a href="javascript:sortlist('hits');"><span class="selectedA">조회순</span></a> | 
			<a href="javascript:sortlist('heart')">좋아요순</a>
		</c:if>
		<c:if test="${sort eq 'heart'}">
			<a href="javascript:sortlist('recent');">최신순</a> | 
			<a href="javascript:sortlist('hits');">조회순</a> | 
			<a href="javascript:sortlist('heart')"><span class="selectedA">좋아요순</span></a>
		</c:if>		
			</td>
		<td class="rctd"><span class="box"><input type="button" value="작성" onclick="location.href='rcwrite'"></span></td>
		<%-- 레시피게시판 포인트증정 : 관리자로그인시만 보임  --%>
 		<c:if test="${(sessionScope.loginUser.userid eq 'admin')}">
		<th rowspan="2">포인트증정</th></c:if></tr>
	<tr><th class="rctd">no.</th>
		<th colspan="3">목록</th>
		<th class="rctd">♥/👀</th>
		</tr>
<c:forEach var="recipe" items="${recipelist}">	
		<tr><td rowspan="2" class="rctd">${recipeno}</td><c:set var="recipeno" value="${recipeno -1}" />
			<td rowspan="2" class="rctd"><img style="width:80px; height:80px;" src="file/${recipe.rcimgurl}"></td>
			<td colspan="2" class="rcleft">
				<a href="rcdetail?rcnum=${recipe.rcnum}">&nbsp;${recipe.rctitle}</a></td>
			<td class="rctd">♥ ${recipe.heartcnt}</td>
			<%-- 레시피게시판 포인트증정 : 관리자로그인시만 보임  --%>
 			<c:if test="${(sessionScope.loginUser.userid eq 'admin')}">
			<td rowspan="2">
				<form action="rcpoint" method="post" name="rcpointform">
					<input type="hidden" name="recipeuserid" value="${recipe.userid}">
					<input type="number" min="500" max="10000" step="500" name="rcpoint" value="${param.rcpoint}" style="width:60px;">
					<span class="box"><input type="submit" value="포인트"></span>
				</form></td></c:if></tr>
		<tr><td class="rcleft">&nbsp;${recipe.userid}</td><td><fmt:formatDate value="${recipe.rcdate}" pattern="YYYY-MM-dd"/></td>
			<td class="rctd">👀${recipe.rcreadcnt}</td></tr>
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
	<tr><td colspan="5">등록된 게시물이 없습니다.</td>
		<td><span class="box"><input type="button" value="작성" onclick="location.href='rcwrite'"></span></td></tr>
</c:if> 
</table></div>
</body></html>