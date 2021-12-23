<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- /WEB-INF/view/user/userlogin.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image/x-icon" href="../img/logo.png">
<title>로그인 / LOGIN</title>
<link href="../css/fonts.css" rel="stylesheet">
<style type="text/css">
	* {
		margin: auto;
	}
	
	table {
		top:15px;
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
	}
	.er {
		text-align:right; 
		padding:0;
		height:20px;
		font-size:5px;
	}
	div {
		height:10px;
		margin-top:10px;
		position:relative;
	}
	.td1 input {
		border-radius:3px;
		border: 1px solid #FD9F28;
		margin-left:0;
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
		width: 70px;
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
	
	#bt2 input {
		color:black;
		background-color:white;
		border: none;
		line-height:2;
		font-size:12px;
		margin-top:20px;
	}
	#bt2 input:hover {
		text-decoration:underline;
		cursor:pointer;
		border: none;
	}
	#bt2 input:active {
		border: none;
	}
	
	p {
		display:inline-block;
		font-size:11px;
		margin-left:3px;
		margin-right:3px;
	}
	p:hover {
		cursor:default;
	}
	#bt2 button,p {margin-top:10px;}
	#a1 > img {
		margin-top:50px;
		height:100px;
	}
</style>
<script type="text/javascript">
function win_open(page) {
	   var op = "width=500, height=350, left=50,top=150";
	   open(page,"",op);
}
</script>
</head>
<body>
<form:form modelAttribute="user" method="post" action="userlogin" name="loginform">
<center><a href="main" id="a1"><img alt="home" src="../img/mk.png"></a><!-- 현재는 임의. 나중에 홈페이지로 이동하도록 수정 -->
	<div>
	<input type="hidden" name="username" value="유효성검증을위한 파라미터" >
	<input type="hidden" name="email" value="valid@aaa.bbb" >
  	<spring:hasBindErrors name="user"><%-- bresult.reject 해당 부분 --%>
    	<font color="red">
    		<c:forEach items="${errors.globalErrors}" var="error">
    			<spring:message code="${error.code}" />
      		</c:forEach>
      	</font>
    </spring:hasBindErrors>
    </div></center>
    <table>
    <tr><th colspan="2"><h3 id="user-name">로그인 / LOGIN</h3></th></tr>
    <tr>
	   	<td class="user-info">아이디</td>
	   	<td class="td1"><form:input path="userid" /></td>
	</tr>
	<tr><td colspan="2" class="er"><font color="red"><form:errors path="userid" /></font></td></tr>
   <tr>
   		<td class="user-info">비밀번호</td>
   		<td class="td1"><form:password path="userpw" /></td>
   </tr>
   <tr><td colspan="2" class="er"><font color="red"><form:errors path="userpw" /></font></td></tr>
   <tr>
   		<td colspan="2" id="bt1">
		<input type="submit" value="로그인">
		<input type="button" value="회원가입" onclick="location.href='userentry'"></td></tr>
   <tr>
		<td colspan="2" id="bt2"><input type="button" value="아이디 찾기" onclick="win_open('idsearch')"><p>|</p>
		<input type="button" value="비밀번호 찾기" onclick="win_open('pwsearch')">
   		</td>
   </tr>
   </table>
</form:form>
</body>
</html>