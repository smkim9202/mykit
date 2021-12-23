<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%-- /WEB-INF/view/board/qadelete.jsp --%>
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>공지&이벤트 글삭제</title>
<link href="../css/board.css" rel="stylesheet">
</head>
<body>
<h3 id="board-title">공지&이벤트 글삭제</h3>
<form:form modelAttribute="board" action="evdelete" method="post" name="f">
<input type="hidden" name="num" value="${board.num}">
<input type="hidden" name="grpnum" value="${board.grpnum}">
<div class="deltable">
<table>
<caption>정말 삭제하시겠습니까?</caption>
	<tr><th>글</th><td>${board.title}</td></tr>
	<tr><td colspan="2" align="center">
		<span class="box"><input type="button" value="공지삭제" onclick="location.href='javascript:document.f.submit()'"></span>
	 	<span class="box"><input type="button" value="돌아가기" onclick="location.href='evdetail?num=${board.num}'"></span>
	</td></tr>
</table></div></form:form></body></html>