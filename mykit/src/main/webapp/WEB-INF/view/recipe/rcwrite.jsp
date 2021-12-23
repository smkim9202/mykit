<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /WEB-INF/view/recipe/rcwrite.jsp--%>   
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 작성</title>
<link href="../css/board.css" rel="stylesheet">
<script>
	<!--img 유효성검사 -->
	function imgCheck(){
		var imgFile = $('#isFile').val();
		if($('#isFile').val() == "") {
			alert("대표사진 등록은 필수입니다.");
		    $("#isFile").focus();
		    return;
		}else{
			location.href="javascript:document.f.submit()"
		}
	}
</script>
</head>
<body>
<h3 id="board-title">밀키트 데뷔하기</h3>
<form:form modelAttribute="recipe" action="rcwrite" enctype="multipart/form-data" name="f">
<input type="hidden" name="userid" value="${loginUser.userid}">
<div class="writetable">
<table>
	<tr><th>&nbsp;</th><td><font color="red"><form:errors path="rctitle" /></font></td></tr>
	<tr><th>제목</th>
		<td><form:input path="rctitle" size="120%" placeholder="레시피이름"/></td>
	</tr>
	<tr><th>대표사진</th><td colspan="3">
		<input type="file" id="isFile" name="rcimg" accept="image/*" /></td>
	</tr>
	<tr><th>내용</th>
    	<td><form:textarea path="rccontent"/>
			<script type="text/javascript">
		  		CKEDITOR.replace("rccontent",{filebrowserImageUploadUrl : "imgupload"});
		 	</script>
	  	  	</td>
	 </tr>
	 <tr><th>&nbsp;</th><td><font color="red"><form:errors path="rccontent" /></font></td></tr>
	 <tr><td colspan="2" align="center">
	 	<span class="box"><input type="button" value="지원하기" onclick="location.href='javascript:imgCheck();'"></span>
	 	<span class="box"><input type="button" value="포기하기" onclick="location.href='rclist'"></span></td></tr>
	 		
</table></div></form:form>
</body>
</html>