<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- /WEB-INF/view/send.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image/x-icon" href="../img/logo.png">
<title>이메일 전송</title>
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
</head>
<body>
<p>이메일 전송을 완료하였습니다</p>
<input type="button" value="닫기" onclick="self.close()">
</body>
</html>