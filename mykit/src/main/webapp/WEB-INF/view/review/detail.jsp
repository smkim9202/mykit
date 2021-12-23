<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%-- /webapp/WEB-INF/view/review/detail.jsp --%>    
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 상세</title>
<link href="../css/fonts.css" rel="stylesheet">
<style type="text/css">
	* {margin: auto;}
	#dv1 {
		position: relative;
		width:1160px;
		margin:50px 25px 100px 25px;
	}
	h4 {margin-bottom:20px;}
	table {
		position:relative;
		border:2px solid #d9d9d9;
		padding:20px;
		width:600px;
	}
	th, td {padding:10px;}
	th {
		width:20%;
		text-align:left;
		border-right:1px solid #d9d9d9;
	}
	td {width:80%;}
	.tr1 th, .tr1 td {border-bottom:1px solid #d9d9d9;}
	#td1 {height:100px;}
	
	#dv2 {margin:20px 0 10px 0;}
	#dv2 a {
		text-decoration: none;
		margin:0 5px;
		background:#FD9F28;
		border-color: #FD9F28;
		font-size:13px;
		padding:2px 10px;
		border-radius:3px;
		color:white;
	}
	#dv2 a:active {
		background-color:#ED9525;
		font-weight:bolder;
	}
</style>
</head>
<body>
<div id="dv1">
	<h4 id="re_h3">${itemname}</h4>
	<table id="review-table">
		<tr class="tr1">
			<th>상품번호</th><td>${review.itemid}</td>
		</tr>
		<tr class="tr1">
			<th>아이디</th><td>${review.userid}</td>
		</tr>
		<tr class="tr1">
			<th>점수</th><td colspan="3">${review.score}</td>
		</tr>
		<tr>
			<th>내용</th><td colspan="3" id="td1">${review.recontent}</td>
		</tr>
	</table>
	<div id="dv2">
		<a href="list?id=${sessionScope.loginUser.userid}">리뷰 목록</a>
		<a href="update?num=${review.renum}">수정</a>
		<a href="delete?num=${review.renum}">삭제</a>
		<a href="../user/myitemlist?id=${sessionScope.loginUser.userid}">구매 목록</a>
	</div>
</div>
</body>
</html>