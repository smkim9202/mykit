<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- /webapp/WEB-INF/view/user/userpassword.jsp --%>   
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" type="image/x-icon" href="../img/logo.png">
<meta charset="UTF-8">
<title>비밀번호 변경</title>
<link href="../css/fonts.css" rel="stylesheet">
<style type="text/css">
	* {
		margin: auto;
	}
	#a1 > img {
		margin-top:60px;
		height:100px;
	}
	table {
		top:20px;
		position: relative;
		border: 1px solid #FD9F28;
		padding:50px 100px 30px;
		margin-bottom:100px;
	}
	th {
		float:left;
		margin-bottom: 25px;
	}
	td {
		text-align:center;
		padding-bottom:15px;
	}
	.er {
		text-align:right; 
		padding:0;
		height:20px;
		font-size:5px;
	}
	div {
		height:10px;
		margin-top:20px;
		position:relative;
	}
	.td1 input {
		border-radius:3px;
		border: 1px solid #FD9F28;
		margin-left:10px;
		margin-right:25px;
		height:20px;
	}
	.td1 input:focus {
		outline:1px solid #FD9F28;
	}
	#bt1 input {
		background-color:#FD9F28;
		border-radius:3px;
		border: none;
		color: white;
		margin-top:12px;
		width:90px;
		height:25px;
		margin-left:3px;
		margin-right:3px;
	}
	#bt1 input:hover {
		cursor:pointer;
	}
	#bt1 input:active {
		background-color:#ED9525;
		font-weight:bolder;
	}
	#i1 {
		font-size:12px;
	}
</style>
<script type="text/javascript">
   function inchk(f) {
	   if(f.chgpass.value != f.chgpass2.value) {
		   alert("변경 비밀번호와 변경 비밀번호 재입력이 다릅니다.");
		   f.chgpass2.value="";
		   f.chgpass2.focus();
		   return false;   
	   }
	   //chgpass 값이 3자리 미만인 경우 오류 발생
	   let passlen = f.chgpass.value.length;
	   if(passlen < 3 || passlen > 10) {
		   alert("비밀번호는 3자리 이상 10자 미만이어야 합니다!");
		   f.chgpass.focus();
		   return false;   
	   }
	   alert("비밀번호가 변경되었습니다! 다시 로그인해주세요.");
	   return true;
   }
</script>
</head>
<body>
<form action="password" method="post" name="f" onsubmit="return inchk(this)">
<center><a href="main" id="a1"><img alt="home" src="../img/mk.png"></a></center><!-- 현재는 임의. 나중에 홈페이지로 이동하도록 수정 -->
<table>
	<tr><th><h3 id="user-name">비밀번호 변경</h3></th></tr>
	<tr><td class="user-info">현재 비밀번호</td><td class="td1"><input type="password" name="password"></td></tr>
	<tr><td class="user-info">변경 비밀번호</td><td class="td1"><input type="password" name="chgpass"></td></tr>
	<tr><td class="user-info">변경 비밀번호 재입력</td><td class="td1"><input type="password" name="chgpass2"></td></tr>
	<tr><td colspan="2" id="bt1">
		<input type="submit" value="비밀번호 변경" id="i1">
		<input type="button" value="취소" onclick="location.href='mypage?id=${sessionScope.loginUser.userid}'"></td></tr>
</table>
</form>
</body>
</html>