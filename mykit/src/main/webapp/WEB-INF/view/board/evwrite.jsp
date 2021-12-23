<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /WEB-INF/view/board/evwrite.jsp--%>   
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지&이벤트 작성</title>
<link href="../css/board.css" rel="stylesheet">
</head>
<body>
<h3 id="board-title">공지&이벤트 등록하기</h3>
<form:form modelAttribute="board" action="evwrite" enctype="multipart/form-data" name="f">
<input type="hidden" name="userid" value="${loginUser.userid}">
<div class="writetable">
<table>
	<tr><th>&nbsp;</th><td><font color="red"><form:errors path="title" /></font></td></tr>
	<tr><th>제목</th>
		<td><form:input path="title" size="120%" /></td></tr>
    <tr><th>내용</th>
    	<td><form:textarea  path="content" />
			<script type="text/javascript">
		  		CKEDITOR.replace("content",{filebrowserImageUploadUrl : "imgupload"});
		 	</script></td></tr>
	<tr><th>&nbsp;</th><td><font color="red"><form:errors path="content" /></font></td></tr>
	<tr><th>첨부파일</th><td><input type="file" name="myfile"></td></tr>
	<tr><td colspan="2" align="center">
		<span class="box"><input type="button" value="공지등록" onclick="location.href='javascript:document.f.submit()'"></span>
	 	<span class="box"><input type="button" value="등록취소" onclick="location.href='evlist'"></span></td></tr>
		
</table></div></form:form>
</body>
</html>