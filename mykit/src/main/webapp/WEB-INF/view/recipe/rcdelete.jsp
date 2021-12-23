<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%-- /WEB-INF/view/recipe/rcdelete.jsp --%>
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>레시피 삭제</title>
<link href="../css/board.css" rel="stylesheet">
</head>
<body>
<h3 id="board-title">밀키트 데뷔포기</h3> 
<form:form modelAttribute="recipe" action="rcdelete" method="post" name="f">
<input type="hidden" name="rcnum" value="${recipe.rcnum}">
<div class="deltable">
<table>
<caption>데뷔를 포기하시겠습니까?</caption>
	<tr><th>제목</th><td>${recipe.rctitle}</td></tr>
	<tr><td colspan="2" align="center">
		<span class="box"><input type="button" value="데뷔포기" onclick="location.href='javascript:document.f.submit()'"></span>
	 	<span class="box"><input type="button" value="돌아가기" onclick="location.href='rcdetail?rcnum=${recipe.rcnum}'"></span></td></tr> 
</table></div></form:form></body></html>
