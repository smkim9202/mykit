<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- /WEB-INF/view/search.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image/x-icon" href="../img/logo.png">
<title>${title}찾기</title>
<style type="text/css">
	input {
		height:25px;
		background-color:#FD9F28;
		border-radius:3px;
		border: 1px solid #FD9F28;
		color: white;
	}
	input:hover {
		cursor:pointer;
	}
	input:active {
		background-color:#ED9525;
		font-weight:bolder;
	}
</style>
<script type="text/javascript">
	function sendclose(){
		opener.document.loginform.userid.value='${result}';
		self.close();
	}
</script>
</head>
<body>
<table>
	<tr><th>${title}찾기</th><td>${result}</td></tr>
	<tr><td colspan="2">
		<c:if test="${title=='아이디'}">
			<input type="button" value="아이디 전송" onclick="sendclose()"></c:if>
		<c:if test="${title!='아이디'}">
			<input type="button" value="닫기" onclick="self.close()"></c:if></td></tr>
</table>
</body>
</html>