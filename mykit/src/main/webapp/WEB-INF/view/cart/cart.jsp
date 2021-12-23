<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%-- /webapp/WEB-INF/view/cart/cart.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
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
	th {
		border: 1px solid lightgray;
		border-bottom:2px solid lightgray;
		padding: 5px 0;
	}
	.th1 {width:450px;}
	.td1 {width:300px; color:#444444;}
	.th2 {width:120px;}
	.th3 {padding:0 10px;}
	.th1, .th2 {border-right:1.5px solid lightgray;}
	.th2, .th3 {border-left:1.5px solid lightgray;}
	td {padding:10px; border:1px solid lightgray;}
	.td2, .td3 {text-align:center;}
	.td3 a {text-decoration:none;}
	#s1 {font-weight:bolder;}
	#d2 {margin-top:15px;}
	h4 {margin:10px 0;}
	p, #dv3 input {margin-top:10px;}
	#dv3 input {
		background-color:#FD9F28;
		border-radius:3px;
		border: none;
		color: white;
		padding:3px 8px;
	}
	#dv3 input:hover {
		cursor:pointer;
	}
	#dv3 input:active {
		background-color:#ED9525;
		font-weight:bolder;
	}
	.td4 {border-top:2px solid lightgray;}
</style>
<script>
	function checkInput(){
		frm = document.ckForm;
		if(frm.usepoint.value==""){
			alert("포인트란이 비어있습니다! 확인해주세요!")
			return frm.usepoint.focus();
		}
		frm.submit();
	}
</script>
</head>
<body>
<div id="dv1">
<h2 id="cart-title">장바구니 상품 목록</h2>
<table>
  	<tr><th colspan="2" class="th1">상품명</th>
  		<th class="th2">가격</th>
  		<th class="th2">수량</th>
  		<th class="th2">합계</th>
  		<th class="th3">삭제</th></tr>
  	<c:set var="tot" value="${0}"/>
	<c:forEach items="${cart.itemSetList}" var="itemSet" varStatus="stat">
    <tr>
    	<td class="td2"><img style="width:100px; height:100px;" src="../imgitem/${itemSet.item.itemimg}"></td>
    	<td class="td1">${itemSet.item.itemname}</td>
    	<td class="td2">${itemSet.item.price}원</td>
    	<td class="td2">${itemSet.quantity}</td>
    	<td class="td2">${itemSet.quantity * itemSet.item.price}원
  		<c:set var="tot" value="${tot +(itemSet.quantity * itemSet.item.price)}"/></td>
      	<td class="td3"><a href="cartDelete?index=${stat.index}">ⓧ</a></td>
    </tr>
    </c:forEach>
 	<tr><td colspan="6" align="right" class="td4"><span id="s1">총 구입 금액 :</span> ${tot}원</td></tr>
</table>
<br>
<div id="dv2">
<h4 class="user-info">${sessionScope.loginUser.username}님, 남은 포인트는 <span class="cart-special blinking">${userpoint}</span>입니다.</h4>
<form action="checkout" id="ckForm" name="ckForm">
<span class="cart-info">포인트 사용 : </span>
<input type="number" name="usepoint" value="0" min="0" max="${userpoint}"/>
<p class="cart-info">${message}</p>
<div id="dv3">
<input type="button" onclick="checkInput()" value="구매하기">
<input type="button" value="쇼핑 계속하기" onclick="location.href='../item/list'">
</div>
</form>
</div>
</div>
</body>
</html>