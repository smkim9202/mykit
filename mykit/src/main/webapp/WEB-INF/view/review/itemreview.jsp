<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%-- /webapp/WEB-INF/view/review/itemreview.jsp --%>    
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link href="../css/fonts.css" rel="stylesheet">
<style type="text/css">
	* {margin: auto;}
	#re_dv1 {
		position: relative;
		width:1000px;
		margin:50px 25px 150px 25px;
	}
	#re_h4 {
		color:#FD9F28;
		margin-bottom:20px;
	}
	#re_h3 {text-align:center;}
	#re_t1 {
		width:1000px;
		border:2.3px solid lightgray;
		padding:10px 20px;
		border-spacing:0;
	}
	#re_td1 {
		font-weight:bolder;
		border-top:1.3px solid lightgray;
	}
	#re_td1, #re_td2, #re_td3 {
		padding:5px 8px;
	}
	#re_td2 {
		font-size:13px;
		border-bottom: 1px solid lightgray;
	}
	#re_sp {font-size:11px;}
	#re_td3 {padding-bottom: 10px;border-bottom:1.3px solid lightgray;}
</style>
</head>
<body>
<div id="re_dv1">
<c:if test="${avgreview <= 0}">
	<p id="re_h3">아직 리뷰가 없어요.😥</p>
</c:if>
<c:if test="${avgreview > 0}">
<h4 id="re_h4">평균 평점 - ${avgreview}</h4>
<table id="re_t1">
	<c:forEach items="${reviewlist}" var="review" varStatus="stat">
	<!-- <tr><th><hr></th></tr> -->
	<tr>
		<td id="re_td1">${review.userid}님</td>
	</tr>
	<tr>
		<td id="re_td2">평점 : ${review.score}점&nbsp;&nbsp;<strong>·</strong>&nbsp;&nbsp;
		<span id="re_sp"><fmt:formatDate value="${review.redate}" pattern="yyyy년 MM월 dd일"/></span></td>
	</tr>
	<tr><td id="re_td3">${review.recontent}</td></tr>
	</c:forEach>
	<!-- <tr><th><hr></th></tr> -->
</table>
</c:if>
</div>
</body>
</html>