<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%-- /WEB-INF/view/board/qadelete.jsp --%>
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>Q&A 글삭제</title>
<link href="../css/board.css" rel="stylesheet">
</head>
<body>
<form:form modelAttribute="board" action="qadelete" method="post" name="f">
<input type="hidden" name="num" value="${board.num}">
<input type="hidden" name="grpnum" value="${board.grpnum}">
<form:hidden path="userid"/>
<div class="deltable">
<table>
<caption>정말 삭제하시겠습니까?</caption>
	<tr><th>제목</th><td>${board.title}</td></tr>
	<tr><td colspan="2" align="center">
		<span class="box"><input type="button" value="문의삭제" onclick="location.href='javascript:document.f.submit()'"></span>
	 	<span class="box"><input type="button" value="돌아가기" onclick="location.href='qadetail?num=${board.num}'"></span>
	</td></tr>
</table></div></form:form></body></html>
