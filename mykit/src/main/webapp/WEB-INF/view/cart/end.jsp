<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%-- /webapp/WEB-INF/view/cart/end.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매 확정 상품</title>
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
	button {
		background-color:#FD9F28;
		border-radius:3px;
		border: none;
		color: white;
		padding:3px 8px;
	}
	button:hover {
		cursor:pointer;
	}
	button:active {
		background-color:#ED9525;
		font-weight:bolder;
	}
	h2 {margin-bottom:20px;}
</style>
</head>
<body>
<div id="dv1">
<h2 id="cart-title">${sale.user.username}님이 구매하신 정보입니다.</h2>
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
<h3 id="cart-title">구매 완료 상품 </h3>
<table id="t2">
  <tr class="cart-info">
  	<th id="th1">상품명</th>
  	<th class="th2">단가</th>
  	<th class="th2">수량</th>
  	<th id="th3">합계</th>
  </tr>
  <c:forEach items="${sale.itemList}" var="saleitem" >
   <tr class="cart-info">
   		<td id="td1">${saleitem.item.itemname}</td>
   		<td class="td2">${saleitem.item.price}원</td>
   		<td class="td2">${saleitem.quantity}개</td>
   		<td class="td2">${saleitem.item.price *saleitem.quantity}원</td>
   </tr>
  </c:forEach>
  <tr>
  	<td colspan="4" align="right" id="td3"><span id="s1">총 구입 금액 : </span><fmt:formatNumber value="${sale.total}" pattern="###,###"/>원</td></tr>
</table>
<div id="dv2">
	<a href="../item/list"><button>상품 목록</button></a>
</div>
</div>
</body>
</html>