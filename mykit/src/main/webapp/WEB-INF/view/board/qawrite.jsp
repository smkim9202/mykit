<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /WEB-INF/view/board/qawrite.jsp--%>   
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A 작성</title>
<link href="../css/board.css" rel="stylesheet">
</head>
<body>
<h3 id="board-title">Q&A 문의하기</h3>
<form:form modelAttribute="board" action="qawrite" enctype="multipart/form-data" name="f">
<input type="hidden" name="userid" value="${loginUser.userid}">
<div class="writetable">
<table>
	<tr><th>&nbsp;</th><td><font color="red"><form:errors path="title" /></font></td></tr>
	<tr><th>제목</th>
		<td><form action="qawrite" method="post" name="qawrite">
			<select name="boardlock" style="width:80px;">
				<option value="bdunlock">공개</option>
				<option value="bdlock">비공개</option>
			</select></form>
			<form:input path="title" size="100%"/></td></tr>
    <tr><th>내용</th>
    	<td><form:textarea  path="content" />
			<script type="text/javascript">
		  		CKEDITOR.replace("content",{filebrowserImageUploadUrl : "imgupload"});
		 	</script></td></tr>
	<tr><th>&nbsp;</th><td><font color="red"><form:errors path="content" /></font></td></tr>
	<tr><td colspan="2" align="center">
		<span class="box"><input type="button" value="문의등록" onclick="location.href='javascript:document.f.submit()'"></span>
	 	<span class="box"><input type="button" value="등록취소" onclick="location.href='qalist'"></span></td></tr>
</table></div></form:form>
</body>
</html>