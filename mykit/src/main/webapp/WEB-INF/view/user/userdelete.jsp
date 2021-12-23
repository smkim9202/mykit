<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>    
<%-- /webapp/WEB-INF/view/user/userdelete.jsp --%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image/x-icon" href="../img/logo.png">
<title>회원 탈퇴</title>
<link href="../css/fonts.css" rel="stylesheet">
<style type="text/css">
	* {
		margin: auto;
	}
	#a1 > img {
		margin-top:100px;
		height:100px;
	}
	table {
		top:10px;
		position: relative;
		border: 1px solid #FD9F28;
		padding:30px 100px 30px;
		margin-bottom:100px;
	}
	th {
		float:left;
		margin-bottom: 25px;
	}
	td {
		text-align:center;
	}
	.td1 {padding-left:30px; color:#444444;}
	.td2 {padding-right:30px;}
	.td3, .td4, .bt, a {padding-top:20px;}
	.bt input , button {
		float:center;
		background-color:#FD9F28;
		border-radius:3px;
		border: none;
		color: white;
		width:70px;
		height:25px;
		margin-left:3px;
		margin-right:3px;
	}
	.bt input:hover, button:hover {
		cursor:pointer;
	}
	.bt input:active, button:active {
		background-color:#ED9525;
		font-weight:bolder;
	}
	.td4 input {
		border-radius:3px;
		border: 1px solid #FD9F28;
		margin-left:10px;
		margin-right:5px;
		height:20px;
	}
	.td4 input:focus {
		outline:1px solid #FD9F28;
	}
</style>
</head>
<body>
<center><a href="main" id="a1"><img alt="home" src="../img/mk.png"></a></center><!-- 현재는 임의. 나중에 홈페이지로 이동하도록 수정 -->
<table>
  <tr><th><h3 id="user-name">회원 탈퇴</h3></th></tr>
  <tr><td class="td1">아이디 :</td><td class="td2">${user.userid}</td></tr>
  <tr><td class="td1">이름 :</td><td class="td2">${user.username}</td></tr>
  <tr><td class="td1">생년월일 :</td><td class="td2"><fmt:formatDate value="${user.birth}"
     pattern="yyyy-MM-dd" /></td></tr>

  <tr><td class="td3">
	<form method="post" action="userdelete" name="deleteform">
    <input type="hidden" name="userid" value="${param.id}"><b>비밀번호 :</b></td><td class="td4"><input type="password" name="password"></td>
    </form></tr>
<tr><td colspan="2" class="bt"><a href="javascript:deleteform.submit()"><button>탈퇴</button></a>
	<input type="button" value="취소" onclick="location.href='mypage?id=${sessionScope.loginUser.userid}'"></td></tr>
</table>
</body>
</html>