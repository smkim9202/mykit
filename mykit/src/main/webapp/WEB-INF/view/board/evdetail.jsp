<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- /WEB-INF/view/board/evdetail.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>공지&이벤트 글상세보기</title>
<link href="../css/board.css" rel="stylesheet">
</head><body>
<h3 id="board-title">공지&이벤트</h3>
<div class="detail">
<div class="tablewrap">
<table>
	<tr><th>제목</th>
		<td colspan="3" class="rcleft">&nbsp;${board.title}</td>
	  	<th>관리자</th>
		<td><fmt:formatDate value="${board.regdate}" pattern="yyyy-MM-dd HH:mm"/></td></tr>
	<tr><th >내용</th>
		<td colspan="5" class="content"><p>${board.content}</p></td></tr>	
	<tr><th>첨부파일</th>
		<td colspan="5" class="rcleft">&nbsp;
			<c:if test="${!empty board.fileurl}">
				<a href="file/${board.fileurl}">${board.fileurl }</a>
			</c:if></td></tr>
	<tr><td colspan="6">
	  <%-- 수정버튼/삭제버튼 관리자 로그인시만 보임 --%>
		<c:if test="${sessionScope.loginUser.userid eq 'admin'}">
			<span class="box"><input type="button" value="수정" onclick="location.href='evupdate?num=${board.num}'"></span>
			<span class="box"><input type="button" value="삭제" onclick="location.href='evdelete?num=${board.num}'"></span>
		</c:if>
		<span class="box"><input type="button" value="목록" onclick="location.href='evlist'"></span>
			</td></tr>
</table></div></div></body></html>