<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /WEB-INF/view/board/qalist.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>    
<!DOCTYPE html>
<html><head><meta charset="UTF-8">
<title>Q&A</title>
<link href="../css/board.css" rel="stylesheet">
<%-- font Awesome : 자물쇠이모티콘 --%>
<link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.css" rel="stylesheet"  type='text/css'>
<script type="text/javascript">
   function listpage(page) {
	   document.searchform.pageNum.value=page;
	   document.searchform.submit();
   }
</script>
</head>
<body>
<h3 id="board-title">Q&A</h3>			
<div class="tablewrap">
<table>
	<tr><td colspan="6">
		<div style="dispaly:inline;">
			<form action="qalist" method="post" name="searchform">
			<input type="hidden" name="pageNum" value="1">
			<select name="searchtype" style="width:100px;">
			<option value="">선택하세요</option>
			<option value="title">제목</option>
			<option value="userid">작성자</option>
			<option value="content">내용</option>
			</select>&nbsp;&nbsp;
		    <script>
		       document.searchform.searchtype.value='${param.searchtype}'
		    </script>
			<input type="text" name="searchcontent" value="${param.searchcontent}"
				style="width:250px;">&nbsp;&nbsp;
			<span class="box">
			<input type="submit" value="검색">
			<input type="button" value="전체보기" onclick="location.href='qalist'">
			</span>
			</form>
		</div>
	</td></tr>
	<c:if test="${listcount>0}"><%-- 등록된 게시물이 존재하는 경우 --%>
		<tr><td class="rctd">총 ${listcount}개</td>
			<td colspan="4">&nbsp;</td>
			<td class="rctd"><span class="box"><input type="button" value="작성" onclick="location.href='qawrite'"></span></td>
		</tr>
		<tr><th>no.</th><th colspan="3">제목</th><th>작성자</th><th>date</th></tr>
		<c:forEach var="board" items="${boardlist}">
		<tr><td>${boardno}</td><c:set var="boardno" value="${boardno -1}" />
			<td colspan="3" class="rcleft">
				<%--비밀글여부 제목 앞에 표시 --%>
				<c:if test="${board.boardlock eq 'bdlock'}">
					&nbsp;<i class="fa fa-lock" aria-hidden="true">&nbsp;</i></c:if>
				<c:if test="${board.boardlock eq 'bdunlock'}">
					&nbsp;&nbsp;&nbsp;&nbsp;</i></c:if>
				<a href="qadetail?num=${board.num}">${board.title}</a>
				</td>
			<!-- 답글인지 원글인지 판단 후 답글에는 관리자로표시 -->
			<c:if test="${board.num ne board.grpnum}"><td>관리자</td></c:if>
			<c:if test="${board.num eq board.grpnum}"><td>${board.userid}</td></c:if>
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
			<tr><td colspan="5">등록된 게시물이 없습니다.</td>
				<td><span class="box"><input type="button" value="작성" onclick="location.href='qawrite'"></span></td></tr>
	</c:if> 
		
</table></div></body></html>