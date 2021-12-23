<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- /WEB-INF/view/board/evupdate.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html><html><head>
<meta charset="UTF-8">
<title>공지&이벤트 글수정</title>
<link href="../css/board.css" rel="stylesheet">
<script type="text/javascript">
	function file_delete(){
		document.updateform.file2.value="";
		document.getElementById("file_desc").style.display="none";
	}
</script>
<style type="text/css"> .errortext {color : red;}</style>
</head><body>
<h3 id="board-title">공지&이벤트 글수정</h3>
<form:form modelAttribute="board" action="evupdate" enctype="multipart/form-data" 
		name="updateform">
<input type="hidden" name="file2" value="${board.fileurl}">
<form:hidden path="num"/>
<form:hidden path="userid"/>
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
	 <tr><th>첨부파일</th>
	 	 <td>
	 	 	<c:if test="${!empty board.fileurl}">
		 	 	<span id="file_desc"><a href="file/${board.fileurl}">${board.fileurl}</a>&nbsp;
		 	 		<input type="button" value="파일 삭제" onclick="location.href='javascript:file_delete()'">
		 	 	</span>
			</c:if>
			<input type="file" name="myfile" id="file1"></td>
	 </tr>
	 <tr><td colspan="2" align="center">
		<span class="box"><input type="button" value="수정완료" onclick="location.href='javascript:javascript:document.updateform.submit()'"></span>
	 	<span class="box"><input type="button" value="수정취소" onclick="location.href='evlist?pageNum=${param.pageNum}'"></span></td></tr>	
		
</table></div></form:form></body></html>