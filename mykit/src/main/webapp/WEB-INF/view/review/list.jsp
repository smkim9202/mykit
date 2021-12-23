<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- /webapp/WEB-INF/view/review/list.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 관리</title>
<link href="../css/fonts.css" rel="stylesheet">
<style type="text/css">
	* {margin: auto;}
	#dv1 {
    	position:relative;
		width:1180px;
		margin:20px 10px 100px 10px;
	}
	table {
		margin-top:20px;
		text-align:center;
		width:1000px;
		border:2px solid lightgray;
		padding:10px;
		table-layout:fixed;
	}
	th, td {
		padding:10px;
		border-collapse: collapse;
	}
	.th1, .td1 {width:90px;}
	.th2 {width:160px;}
	.th3 {width:400px;}
	.th1, .th3 {border-right:2px solid lightgray;}
	.td1, .td2, .td3 {
		border-top:2px solid lightgray;
		border-bottom:1px solid lightgray;
	}
	.td1, .td3 {border-right:1px solid lightgray;}
	.td3 {
		text-align:left;
		display:block;
		white-space:nowrap;
		overflow:hidden;
		text-overflow:ellipsis;
	}
	#dv2 { margin-top: 25px;}
	button {
		font-size:12px;
		padding:2px 5px;
		text-decoration:none;
		border:none;
		background:lightgray;
		border-radius:3px;
		color:black;
	}
	button:active {background-color:#C3C3C3;}
	#dv2 input {
		background-color:#FD9F28;
		border-radius:3px;
		border: none;
		color: white;
		padding:3px 8px;
		margin:0 5px;
		height:24px;
		width:80px;
	}
	button:hover, #dv2 input:hover {
		cursor:pointer;
	}
	#dv2 input:active {
		background-color:#ED9525;
		font-weight:bolder;
	}
</style>
</head>
<body>
<div id="dv1">
<br>
<h2 id="review-title">리뷰 목록</h2>
<table id="review-table">
	<tr>
		<th class="th1">리뷰 번호</th>
		<th class="th1">상품 번호</th>
		<th class="th1">나의 점수</th>
		<th class="th3">리뷰 내용</th>
		<th class="th2">작성 날짜</th>
	</tr>
	<c:forEach items="${reviewList}" var="review">
	<tr>
		<td class="td1">${review.renum}</td>
		<td class="td1">${review.itemid}</td>
		<td class="td1">${review.score}</td>
		<td class="td3">${review.recontent}</td>
		<td class="td2">
			<fmt:formatDate value="${review.redate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	</tr>
	<tr>
		<td colspan="5">
			<a href="detail?num=${review.renum}"><button>보기</button></a>
			<a href="update?num=${review.renum}"><button>수정</button></a>
			<a href="delete?num=${review.renum}"><button>삭제</button></a></td>
	</c:forEach>
</table>
<div id="dv2">
	<input type="button" value="MyPage" onclick="location.href='../user/mypage?id=${sessionScope.loginUser.userid}'">
	<input type="button" value="구매 내역" onclick="location.href='../user/myitemlist?id=${sessionScope.loginUser.userid}'">
</div>
</div>
</body>
</html>