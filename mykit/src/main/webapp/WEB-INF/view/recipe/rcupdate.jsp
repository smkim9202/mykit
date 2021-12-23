<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- /WEB-INF/view/recipe/rcupdate.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html><html><head>
<meta charset="UTF-8">
<title>레시피 수정</title>
<link href="../css/board.css" rel="stylesheet">
<script type="text/javascript">
	function file_delete(){
		document.updateform.file2.value="";
		document.getElementById("file_desc").style.display="none";
	}
</script>
<script type="text/javascript">
	<!--img 유효성검사 -->
	function imgCheck(){
		var imgFile = $('#isFile').val();
		if($('#isFile').val() == "") {
			alert("대표사진 등록은 필수입니다.");
		    $("#isFile").focus();
		    return;
		}else{
			location.href="javascript:document.updateform.submit()"
		}
	}
</script>
</head><body>
<h3 id="board-title">밀키트 데뷔하기</h3>
<form:form modelAttribute="recipe" action="rcupdate" enctype="multipart/form-data" 
		name="updateform">
<input type="hidden" name="file2" value="${recipe.rcimgurl}">
<form:hidden path="rcnum"/>
<form:hidden path="userid"/>
<div class="writetable">
<table>
	<tr><th>&nbsp;</th><td><font color="red"><form:errors path="rctitle" /></font></td></tr>
	<tr><th>제목</th>
		<td><form:input path="rctitle" size="120%" /></td></tr>
	<tr><th>대표사진</th>
	 	 <td>
	 	 	<c:if test="${!empty recipe.rcimgurl}">
		 	 	<span id="file_desc"><a href="file/${recipe.rcimgurl}">${recipe.rcimgurl}</a>&nbsp;
		 	 		<input type="button" value="파일 삭제" onclick="location.href='javascript:file_delete()'">
		 	 	</span>
			</c:if>
			<input type="file" name="rcimg" id="file1"></td>
 	</tr>
	<tr><th>내용</th>
    	<td><form:textarea  path="rccontent" />
			<script type="text/javascript">
		  		CKEDITOR.replace("rccontent",{filebrowserImageUploadUrl : "imgupload"});
		 	</script></td></tr>
	 <tr><th>&nbsp;</th><td><font color="red"><form:errors path="rccontent" /></font></td></tr>
	 <tr><td colspan="2" align="center">
	 	<span class="box"><input type="button" value="수정완료" onclick="location.href='javascript:imgCheck();'"></span>
	 	<span class="box"><input type="button" value="수정취소" onclick="location.href='rclist?pageNum=${param.pageNum}'"></span></td></tr>
</table></div></form:form></body></html>