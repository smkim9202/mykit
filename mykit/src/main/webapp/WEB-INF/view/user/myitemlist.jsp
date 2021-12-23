<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>    
<%-- /WEB-INF/view/user/myitemlist.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매 내역</title>
<link href="../css/fonts.css" rel="stylesheet">
<style type="text/css">
	* {margin: auto;}
	#dv1 {
		position:relative;
		width:1180px;
		margin:0 10px 100px 10px;
	}
	h2 {margin-bottom:20px;}
	#t1 {
		position: relative;
		border:2px solid #FD9F28;
 		border-spacing:0;
	}
	#th1, #th2, #th3 {
		border-bottom: 2px solid #FD9F28;
		width:320px;
		background:#FD9F28;
		color:white;
		font-family:'NanumBold';
	}
	.th1 {width:400px;}
	.th2, .th3 {width:120px;}
	.th3 {padding:0 10px;}
	
	#th1, #th2 {border-right:1.5px solid #FD9F28;}
	#th2, #th3 {border-left:1.5px solid #FD9F28;}
	
	
	.th1, .th2 {border-right:1.5px solid lightgray;}
	.th2, .th3 {border-left:1.5px solid lightgray;}
	.th1, .th2, .th3 {border-bottom:2px solid lightgray;}
		
	.title {width:250px;}
	.td1, .td2 {text-align:center;}
	.td1, .td2, .title {
		padding:10px; 
		border:1px solid lightgray;
	}
	.td3 a {text-decoration:none;}
	#t2 {
		margin:5px 0 15px 14px;
		font-size:14px;
		border:2px solid lightgray;
 		border-spacing:0;
	}
	#td3, .td3 {
		text-align:center;
		padding:10px;
		border:2px solid #FD9F28;
	}
	#td3 a, #td3 a:visited {
		color:black;
		font-weight:bolder;
	}
	#dv2 {margin-top:20px;}
	.td2 a {
		font-size:12px;
		padding:3px;
		text-decoration:none;
		border:1px solid lightgray;
		background:lightgray;
		border-radius:3px;
		color:black;
	}
	.td2 a:active {background-color:#C3C3C3;}
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
</style>
<script type="text/javascript">
   $(document).ready(function(){
	 $(".saleLine").each(function() { 
	     $(this).hide();
	 })
   })
   function list_disp(id) {
	   $("#"+id).toggle();
   }
</script>
</head>
<body>
<div id="dv1">
<h2 id="user-name">구매 내역</h2>
<table id="t1">
   <tr>
   	<th id="th1">주문 번호</th>
   	<th id="th2">주문 일자</th>
   	<th id="th3">총 주문 금액</th>
   </tr>
   <c:forEach items="${salelist}" var="sale" varStatus="stat">
   	 <tr>
     	<td id="td3"><a href="javascript:list_disp('saleLine${stat.index}')">${sale.saleid}</a></td>
     	<td class="td3"><fmt:formatDate value="${sale.saledate}" pattern="yyyy-MM-dd"/></td>
     	<td class="td3"><fmt:formatNumber value="${sale.saleamount}" pattern="#,###"/>원</td>
     </tr>
     <tr id="saleLine${stat.index}" class="saleLine">
       <td colspan="3">
       		<table id="t2">
         		<tr>
         			<th colspan="2" class="th1">상품명</th>
         			<th class="th2">단가</th>
        			<th class="th2">수량</th>
        			<th class="th2">총액</th>
        			<th class="th3">리뷰</th>
        		</tr>
         		<c:forEach items="${sale.itemList}" var="saleItem">
           		<tr>
           			<td class="td1"><img style="width:100px; height:100px;" src="../imgitem/${saleItem.item.itemimg}"></td>
           			<td class="title">${saleItem.item.itemname}</td>
               		<td class="td1"><fmt:formatNumber value="${saleItem.item.price}" pattern="#,###"/>원</td>
               		<td class="td1">${saleItem.quantity}개</td>
         			<td class="td1"><fmt:formatNumber value="${saleItem.quantity * saleItem.item.price}" pattern="#,###" />원</td>
         			<td class="td2">
         				<a href="../review/write?userid=${sessionScope.loginUser.userid}&itemid=${saleItem.item.itemid}">리뷰 작성</a>
         			</td>
         		</tr>
         		</c:forEach>    
       		</table>
       </td>
     </tr>
   </c:forEach>
</table>
<div id="dv2">
	<input type="button" value="돌아가기" onclick="location.href='../user/mypage?id=${sessionScope.loginUser.userid}'">
</div>
</div>
</body>
</html>