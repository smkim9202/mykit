<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- /WEB-INF/view/board/qaupdate.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html><html><head>
<meta charset="UTF-8">
<title>Q&A 글수정</title>
<link href="../css/board.css" rel="stylesheet">
</head><body>
<h3 id="board-title">Q&A 글수정</h3>
<form:form modelAttribute="board" action="qaupdate" enctype="multipart/form-data" 
		name="updateform">
<form:hidden path="num"/>
<form:hidden path="userid"/>
<input type="hidden" name="file2" value="">
<div class="writetable">
<table>
	<tr><th>&nbsp;</th><td><font color="red"><form:errors path="title" /></font></td></tr>
	<tr><th>제목</th>
		<td><form:input path="title" size="120%" /></td>
	</tr>
	<tr><th>내용</th>
    	<td><form:textarea  path="content" />
			<script type="text/javascript">
		  		CKEDITOR.replace("content",{filebrowserImageUploadUrl : "imgupload"});
		 	</script></td></tr>
	<tr><th>&nbsp;</th><td><font color="red"><form:errors path="content" /></font></td></tr>
	<tr><td colspan="2" align="center">
		<span class="box"><input type="button" value="수정완료" onclick="location.href='javascript:document.updateform.submit()'"></span>
	 	<span class="box"><input type="button" value="수정취소" onclick="location.href='qalist?pageNum=${param.pageNum}'"></span></td></tr>	
</table></div></form:form></body></html>