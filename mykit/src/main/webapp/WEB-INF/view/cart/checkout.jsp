<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- /webapp/WEB-INF/view/cart/checkout.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매 전 상품 목록 보기</title>
<link href="../css/fonts.css" rel="stylesheet">
<style type="text/css">
	* {margin: auto;}
	#dv1 {
		position:relative;
		width:1180px;
		margin:0 10px 100px 10px;
	}
	#t1 {
		top:20px;
		position: relative;
		border:2px solid #FD9F28;
 		border-spacing:0;
		margin: 0 0 50px 0;
		padding:20px;
	}
	#t1 th {
		border-right: 2px solid #FD9F28;
		padding-right:15px;
	}
	#t1 td {padding:10px 20px;}
	
	#t2 {
		top:20px;
		position: relative;
		border:2px solid lightgray;
 		border-spacing:0;
 	}
	#t2 th {
		border-bottom:2px solid lightgray;
		padding:3px 0;
	}
	#th1, .th2 {border-right:1.5px solid lightgray;}
	.th2, #th3 {border-left:1.5px solid lightgray;}
	
	#td1 {
		display:block;
		width:380px;
		text-overflow:ellipsis;
		overflow:hidden;
		white-space:nowrap;
	}
	.td2 {
		width:80px;
		text-align:center;
	}
	#td1, .td2 {
		border:1px solid lightgray;
		padding: 3px;
	}
	#td3 {
		border-top:2px solid lightgray;
		padding: 3px;
	}
	#s1 {font-weight:bolder;}
	p {padding:5px;}
	
	#dv2 {margin-top:50px;}
	#dv2 input {
		background-color:#FD9F28;
		border-radius:3px;
		border: none;
		color: white;
		padding:3px 8px;
	}
	#dv2 input:hover {
		cursor:pointer;
	}
	#dv2 input:active {
		background-color:#ED9525;
		font-weight:bolder;
	}
	h2 {margin-bottom:20px;}
</style>
</head>
<body>
<div id="dv1">
<h2 id="cart-title">구매 전 상품 목록 보기</h2>
<h3 id="cart-title">배송지 정보</h3>
<table id="t1">
	<tr class="cart-info">
		<th width="30%">아이디</th>
      	<td width="70%">${sessionScope.loginUser.userid}</td>
    </tr>
    <tr class="cart-info">
    	<th width="30%">이름</th>
      	<td width="70%">${sessionScope.loginUser.username}</td>
    </tr>
    <tr class="cart-info">
    	<th width="30%">우편번호</th>
    	<td width="70%">${sessionScope.loginUser.zipcode}</td>
    </tr>
  	<tr class="cart-info">
  		<th width="30%">주소</th>
      	<td width="70%">${sessionScope.loginUser.address}</td>
    </tr>
  	<tr class="cart-info">
  		<th width="30%">전화번호</th>
      	<td width="70%">${sessionScope.loginUser.phoneno}</td>
    </tr>
</table>
<h3 id="cart-title">구매 상품</h3>
<table id="t2">
	<tr class="cart-info">
		<th id="th1">상품명</th>
		<th class="th2">단가</th>
		<th class="th2">수량</th>
		<th id="th3">합계</th>
	</tr>
  	<c:forEach items="${sessionScope.CART.itemSetList}" var="itemSet" varStatus="stat">
   	<tr class="cart-info">
   		<td id="td1">${itemSet.item.itemname}</td>
   		<td class="td2">${itemSet.item.price}원</td>
   		<td class="td2">${itemSet.quantity}개</td>
   		<td class="td2">${itemSet.item.price *itemSet.quantity}원</td></tr>
  	</c:forEach>
  	<tr>
  		<td colspan="4" align="right" id="td3"><p><span id="s1">총 구입 금액 : </span>${sessionScope.CART.total}원</p>
  		<p>할인 받으실 금액 : ${usepoint}원</p></td></tr>
</table>
<div id="dv2">
<form action="end">
	<input type="hidden" name="usepoint" value="${usepoint}">
	<input type="submit" value="구매 확정">
	<input type="button" value="상품 목록" onclick="location.href='../item/list'">
</form>
</div>
</div>
</body>
</html>