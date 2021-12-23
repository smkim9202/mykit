<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>    
<%-- /WEB-INF/view/user/mypage.jsp --%>    
<!DOCTYPE>
<html>
<head>
<link rel="shortcut icon" type="image/x-icon" href="../img/logo.png">
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MyPage</title>
<link href="../css/fonts.css" rel="stylesheet">
<style type="text/css">
	* {
		margin: auto;
	}
	#a1 > img {
		margin-top:50px;
		height:100px;
	}
	th {float:left;}
	#t1 {
		top:15px;
		position: relative;
		border: 1px solid #FD9F28;
		padding:30px 80px 50px 80px;
		margin-bottom:100px;
	}
	#t2 {
		top:15px;
		position: relative;
		padding:0 80px 30px 80px;
		
	}
	#t2 td {
		text-align:center;
		padding: 0 10px 10px 10px;
	}
	.td1 {font-weight:bolder; color:#444444;}
	.bt1, .bt2 {text-align:center;}
	.bt1 input, .bt2 input {
		background-color:#FD9F28;
		border-radius:3px;
		border: none;
		color: white;
		margin-left:3px;
		margin-right:3px;
	}
	.bt1 input {
		margin-top:5px;
		width: 250px;
		height:25px;
	}
	.bt2 input {
		margin-top:10px;
		width:90px;
		height:25px;
	}
	.bt1 input:hover, .bt2 input:hover {
		cursor:pointer;
	}
	.bt1 input:active, .bt2 input:active {
		background-color:#ED9525;
		font-weight:bolder;
	}
	#i1 {
		font-size:12px;
	}
	.d_wrap {
		width:700px;
		height:450px;
		top:90px;
		position: relative;
		border: 1px solid #FD9F28;
		margin-bottom:200px;
	}
	.d1 {
		float:left;
		background:#FD9F28;
		color:black;
		top:0;
		width:180px;
		height:450px;
	}
	.d1 h3 {
		position:relative;
		float:left;
		top:20px;
		left: 50%;
		transform: translate(-50%, 0%);
	}
	button {
		top:40px;
		width:180px;
		height:55px;
		position:relative;
		color:black;
		border:1px solid #FD9F28;
		background:none;
		font-size:15px;
	}
	button:hover {
		cursor:pointer;
	}
	.clear {clear:both;}
	button.on {background-color: white; font-weight:bolder;}
	
	/* .d1 p {height:150px;} */
	#a2 > img {
		position:relative;
		top:120px;
		border-radius:70%;
		background:white;
		width:50px;
		height:50px;
		border:1px solid white;
		left:50%;
		transform: translate(-50%, 0%);
	}
	#a2 > img:active {
		border: 1px solid #ED9525;
	}
	.d1 input {
		position:absolute;
		margin:0 27px;
		top:380px;
		border:1px solid #FD9F28;
		background:none;
		width:27px;
	}
	.d1 input:hover {
		cursor:pointer;
	}
	.d1 input:active {
		margin-top:1px;
		width:26px;
		height:26px;
	}
	.d2 > p {
		text-align:center;
		padding-top:150px;
		font-size:30px;
	}
</style>
<script type="text/javascript">
	$(function() {
		$('button').click(function() {
			$('button').removeClass()
				$(this).addClass('on')
		})
	})
</script>
</head>
<body>
<c:if test="${loginUser.userid != 'admin'}">
<center><a href="main" id="a1"><img alt="home" src="../img/mk.png"></a></center>
<div>
<table id="t1">
	<tr><th><h3 id="user-name">${sessionScope.loginUser.username}님</h3></th></tr>
	<tr><td>
	<table id="t2">
		<tr><td class="td1">아이디 : </td><td class="user-info">${sessionScope.loginUser.userid}</td></tr>
		<tr><td class="td1">이름 : </td><td class="user-info">${sessionScope.loginUser.username}</td></tr>
		<tr><td class="td1">포인트 : </td><td class="user-special blinking">${rpoint}</td></tr>
		<tr><td colspan="2" class="bt1">
			<input type="button" value="장바구니"  onclick="location.href='../cart/cartView'">
		</tr>
		<tr><td colspan="2" class="bt1">
			<input type="button" value="구매목록"  onclick="location.href='myitemlist?id=${sessionScope.loginUser.userid}'">
		</tr>
		<tr><td colspan="2" class="bt1">
			<input type="button" value="리뷰관리"  onclick="location.href='../review/list?id=${sessionScope.loginUser.userid}'">
		</tr>
	</table>
	</td></tr>
	<tr><td class="bt2">
		<input class="user-info" type="button" value="수정"  onclick="location.href='userupdate?id=${sessionScope.loginUser.userid}'">
		<input class="user-info" type="button" value="비밀번호 수정"  onclick="location.href='password'" id="i1">
		<input class="user-info" type="button" value="로그아웃"  onclick="location.href='userlogout'">
		<c:if test="${sessionScope.loginUser.userid != 'admin'}">
			<input type="button" value="탈퇴"  onclick="location.href='userdelete?id=${sessionScope.loginUser.userid}'">
		</c:if>
	</td></tr></table>
</div>
</c:if>
<c:if test="${loginUser.userid == 'admin'}">
<div class="d_wrap">
<div class="d1">
	<h3 class="admin-name">${loginUser.username}&nbsp;/&nbsp;${loginUser.userid}</h3>
	<button type="button" onclick="location.href='../admin/list'">회원관리</button>
	<button type="button" onclick="location.href='../item/list'">상품관리</button>
	<button type="button" onclick="location.href='../recipe/rclist'">레시피 게시판</button>
	<a href="main" id="a2"><img alt="home" src="../img/home.png"></a><!-- 현재는 임의. 나중에 홈페이지로 이동하도록 수정 -->
	<input type="image" src="../img/out.png" onclick="location.href='userlogout'">
</div>
<div class="d2">
	<p class="user-special">어서오세요. 관리자님</p>
</div>
</div>
</c:if>
</body>
</html>