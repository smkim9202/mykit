<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%-- /webapp/WEB-INF/view/board/qareply.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>Q&A 답글</title>
<link href="../css/board.css" rel="stylesheet">
</head><body>
<h3 id="board-title">Q&A 답글</h3>
<form:form modelAttribute="board" action="qareply" method="post" name="f">
  <form:hidden  path="num" />
  <form:hidden  path="grpnum" />
  <form:hidden  path="userid" />
<div class="writetable">
<table>
	<tr><th>&nbsp;</th><td><font color="red"><form:errors path="title" /></font></td></tr>
	<tr><th>제목</th>
		<td><form action="qareply" method="post" name="qareply">
			<select name="boardlock" style="width:80px;">
				<option value="bdunlock">공개</option>
				<%-- 원글이 비공개면 비공개 기본선택 --%>
				<c:if test="${board.boardlock eq 'bdlock'}">
					<option value="bdlock" selected>비공개</option></c:if>
				<c:if test="${board.boardlock eq 'bdunlock'}">
					<option value="bdlock">비공개</option></c:if>		
			</select></form>
			<form:input path="title" size="100%" value="└ RE : ${board.title}"/></td></tr>
   <tr><th>내용</th>
    	<td><textarea name="content"><p><hr>원글${board.content}</p></textarea>
			<script type="text/javascript">
		  		CKEDITOR.replace("content",{filebrowserImageUploadUrl : "imgupload"});
		 	</script></td></tr>
	<tr><th>&nbsp;</th><td><font color="red"><form:errors path="content" /></font></td></tr>
	 <tr><td colspan="2" align="center">
  	 	<span class="box"><input type="button" value="답변등록" onclick="location.href='javascript:document.f.submit()'"></span>
	 	<span class="box"><input type="button" value="등록취소" onclick="location.href='qalist'"></span></td></tr>    
</table></div></form:form></body></html>