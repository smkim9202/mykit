<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- /webapp/WEB-INF/view/item/list.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 목록</title>
<link href="../css/fonts.css" rel="stylesheet">
<style type="text/css">
	* {margin: auto;}
	button {
		border-radius:3px;
		border: 1px solid #FD9F28;
		border:none;
		background:#FD9F28;
		color:white;
		height:20px;
		padding:2px 5px;
		height:25px;
		position:relative;
	}
	#list-item-button1 {margin-top:10px;}
	button:hover {cursor:pointer;}
	button:active {
		background-color:#ED9525;
		font-weight:bolder;
	}
	.dv1 {
		position:relative;
		width:1160px;
	}
	.dv2 {
		position:relative;
		width:1160px;
		margin-top:20px;
		margin-left:15px;
	}
	.dv3 {
		float:left;
		width:250px;
		padding:18px;

	}
	.dv3 button {
		position:relative;
		margin-top:10px;
		}
	.pid {
		font-size:25px;
		font-weight:bolder;
		color:#FD9F28;
		float:left;
		padding-left:5px;
	}
	.pname {
		font-size:15px;
		font-weight:bolder;
		overflow:hidden;
		text-overflow:ellipsis;
		white-space:nowrap;
		width: 250px;
		height: 20px;
		margin:5px 0;
	}
</style>
</head>
<body>
<c:if test="${loginUser.userid == 'admin'}">
	<div class="dv1"><a href="create"><button id="list-item-button1">상품 등록</button></a></div>
	<div class="dv2">
		<c:forEach items="${itemList}" var="item">
			<div class="dv3">
				<p class="pid">${item.itemid}</p>
				<p><a href="detail?id=${item.itemid}">
				<c:if test="${item.stock == 0}">
					<img style="width:250px; height:250px; opacity:0.5;" src="../imgitem/${item.itemimg}" class="img1">
				</c:if>
				<c:if test="${item.stock != 0}">
					<img style="width:250px; height:250px;" src="../imgitem/${item.itemimg}" class="img1">
				</c:if>
				</a></p>
				<c:if test="${item.stock == 0}">
				<p class="pname" style="color:red;">${item.itemname}</p>
				</c:if>
				<c:if test="${item.stock != 0}">
				<p class="pname">${item.itemname}</p>
				</c:if>
				<p class="pname"><fmt:formatNumber value="${item.price}" type="CURRENCY" currencySymbol=""/>원</p>
				<a href="edit?id=${item.itemid}"><button id="list-item-button2">수정</button></a>
				<a href="confirm?id=${item.itemid}"><button id="list-item-button2">삭제</button></a>
			</div>
		</c:forEach>
	</div>
</c:if>
<c:if test="${loginUser.userid != 'admin'}">
	<div class="dv2">
		<c:forEach items="${itemList}" var="item">
			<div class="dv3">
				<p class="pid">${item.itemid}</p> 
				<a href="detail?id=${item.itemid}">
				<c:if test="${item.stock == 0}">
					<img style="width:250px; height:250px; opacity:0.5;" src="../imgitem/${item.itemimg}" class="img1">
				</c:if>
				<c:if test="${item.stock != 0}">
					<img style="width:250px; height:250px;" src="../imgitem/${item.itemimg}" class="img1">
				</c:if>
				</a>
				<c:if test="${item.stock == 0}">
				<p class="pname" style="color:red;">${item.itemname}</p>
				</c:if>
				<c:if test="${item.stock != 0}">
				<p class="pname">${item.itemname}</p>
				</c:if>
				<p class="pname"><fmt:formatNumber value="${item.price}" type="CURRENCY" currencySymbol=""/>원</p>
			</div>
		</c:forEach>
	</div>
  </c:if>
  </body>
  </html>