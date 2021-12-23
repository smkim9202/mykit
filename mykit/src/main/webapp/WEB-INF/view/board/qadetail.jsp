<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- /WEB-INF/view/board/qadetail.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>Q&A 글상세보기</title>
<link href="../css/board.css" rel="stylesheet">
</head><body>
<h3 id="board-title">Q&A</h3>
<div class="detail">
<div class="tablewrap">
<table>
	<tr><th>제목</th>
		<td colspan="3" class="rcleft">&nbsp;${board.title}</td>
	  <!-- 답글인지 원글인지 판단 후 답글에는 관리자로표시 -->
		<c:if test="${board.num ne board.grpnum}"><td>작성자 : 관리자</td></c:if>
		<c:if test="${board.num eq board.grpnum}"><td>작성자 : ${board.userid}</td></c:if>
		<td><fmt:formatDate value="${board.regdate}" pattern="yyyy-MM-dd HH:mm"/></td></tr>
	<tr><th>내용</th>
		<td colspan="5" class="content"><p>${board.content}</p></td></tr>
	<%--  Q&A에서 첨부파일 삭제
	<tr><td>첨부파일</td>
		<td colspan="5" class="rcleft">&nbsp;
			<c:if test="${!empty board.fileurl}">
				<a href="file/${board.fileurl}">${board.fileurl }</a>
			</c:if></td></tr>--%>
	<tr><td colspan="6">
		  <%-- 답변버튼 원글상세보기(답글에서는 안보임)에서 and 관리자 로그인시만 보임 --%>
		<c:if test="${(board.num eq board.grpnum) && (sessionScope.loginUser.userid eq 'admin')}">
			<span class="box"><input type="button" value="답변" onclick="location.href='qareply?num=${board.num}'"></span>
		</c:if>
		<c:if test="${board.num ne board.grpnum}">
			<%-- 답글에서는 수정버튼/삭제버튼 관리자 로그인시 보임 --%>
	        <c:if test="${(sessionScope.loginUser.userid eq 'admin')}">
				<span class="box"><input type="button" value="수정" onclick="location.href='qaupdate?num=${board.num}'"></span>
				<span class="box"><input type="button" value="삭제" onclick="location.href='qadelete?num=${board.num}'"></span>
			</c:if>
		</c:if>
		<c:if test="${board.num eq board.grpnum}">
		    <%-- 원글에서는 수정버튼/삭제버튼 관리자 로그인시 or 작성자로그인시만 보임 --%>
        	<c:if test="${(sessionScope.loginUser.userid eq 'admin') || (sessionScope.loginUser.userid eq board.userid) }">
				<span class="box"><input type="button" value="수정" onclick="location.href='qaupdate?num=${board.num}'"></span>
				<span class="box"><input type="button" value="삭제" onclick="location.href='qadelete?num=${board.num}'"></span>
			</c:if>
		</c:if>

		
		<span class="box"><input type="button" value="목록" onclick="location.href='qalist'"></span>
		</td></tr>
</table></div></div></body></html>