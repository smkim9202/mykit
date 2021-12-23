<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- /webapp/WEB-INF/view/admin/list.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>
<link href="../css/fonts.css" rel="stylesheet">
<style type="text/css">
	* {margin: auto;}
	#dv1 {
		position:relative;
		width:1180px;
		margin:0 10px 100px 10px;
	}
	table {
		top:20px;
		position: relative;
		border: 2px solid lightgray;
		border-spacing:0;
	}
	th, td {
		padding:10px;
		font-size:14px;
	}
	th {border-bottom:2px solid lightgray;}
	.th1, .th2 {border-right:1.5px solid lightgray;}
	.th2, .th3 {border-left:1.5px solid lightgray;}
	td {border: 1px solid lightgray;}
	.td1, .td2 {text-align:center; font-family:'Nanum';}
	#dv2 {
		position:relative;
		top:50px;
	}
	.td2 a {
		font-size:12px;
		padding:1px;
		text-decoration:none;
		border:1px solid lightgray;
		background:lightgray;
		border-radius:3px;
		color:black;
	}
	.td2 a:active {background-color:#C3C3C3;}
	#dv2 input {
		border:none;
		width:80px;
		height:22px;
		margin:2px;
	}
	#dv2 input {
		background-color:#FD9F28;
		border-radius:3px;
		color: white;
	}
	button:hover, #dv2 input:hover {
		cursor:pointer;
	}
	#dv2 input:active {
		background-color:#ED9525;
		font-weight:bolder;
	}
</style>
<script type="text/javascript">
   function allchkbox(allchk) {
	   $(".idchks").prop("checked",allchk.checked)
   }
</script>
</head>
<body>
<div id="dv1">
<form action="mailForm" method="post">
<h3 id="cart-title">회원 목록</h3>
  <table>
  <tr>
  	<th class="th1" width="70px">아이디</th>
  	<th class="th2" width="60px">이름</th>
  	<th class="th2"  width="90px">전화</th>
  	<th class="th2" width="80px">생일</th>
  	<th class="th2" width="70px">이메일</th>
  	<th class="th2"  width="60px">우편번호</th>
  	<th class="th2" width="240px">주소</th>
  	<th class="th2" width="90px">기타</th>
  	<th class="th3"><input type="checkbox" name="allchk" onchange="allchkbox(this)"></th>
  </tr>
  <c:forEach items="${list}" var="user">
  <tr>
  	<td class="td1">${user.userid}</td>
  	<td class="td1">${user.username}</td>
  	<td>${user.phoneno}</td>
    <td class="td1"><fmt:formatDate value="${user.birth}" pattern="yyyy-MM-dd"/></td>
    <td>${user.email}</td>
    <td class="td1">${user.zipcode}</td>
    <td>${user.address}</td>
    <td class="td2">
    	<a href="../admin/adminupdate?id=${user.userid}">수정</a>
    	<a href="../admin/admindelete?id=${user.userid}">강제탈퇴</a>
    </td>
    <td><input type="checkbox" name="idchks" class="idchks" value="${user.userid}"></td>
  </tr>
  </c:forEach>
  </table>
<div id="dv2">
	<input type="submit" value="메일 보내기">
    <input type="button" value="돌아가기" onclick="location.href='../user/mypage?id=${sessionScope.loginUser.userid}'">
</div>
</form>
</div>
</body>
</html>
