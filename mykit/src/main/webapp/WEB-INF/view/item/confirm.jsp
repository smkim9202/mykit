<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- /webapp/WEB-INF/view/item/confirm.jsp --%>    
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 삭제 전 확인</title>
<link href="../css/fonts.css" rel="stylesheet">
<style type="text/css">
	* {margin: auto;}
	h2 {margin-bottom:15px;}
	#title-action{color:#FD9F28;}
	#dv1 {
		position:relative;
		width:1160px;
		margin:0 10px;
	}
	#dv2 {
		float:left;
		margin:10px 10px 50px 10px;
		width:550px;
		}
	#dv2 img {
		padding-left:10px;
		width:500px;
	}
	.t1 {
		position:relative;
		width:1100px;
	}
	#dv3 {
		float:right;
		margin-top:20px;
		margin-right:55px;
	}
	.t1 {
		width:535px;
		margin-top:10px;
	}
	.t1 th {
		text-align:left;
		padding: 10px 0 30px 5px;
	}
	.td1 {padding-left:15px;}
	.td1, .td2, .td3 {padding-top:35px;}
	.td2 {padding-right:15px;}
	.t2 {width:100%; margin-top:10px;}
	.td3 {text-align:center;}
	.td3 input {margin:10px;}
	.td3 input:hover {cursor:pointer;}
	.inp1, .inp2 {
		width:200px;
		height:60px;
		font-size:18px;
		font-weight:bolder;
		border-radius:3px;
		border:2px solid #FD9F28;
	}
	.inp1 {
		background:#FD9F28;
		color:white;
	}
	.inp1:active {background:#ED9525;}
	.inp2 {
		background:white;
		color:#FD9F28;
	}
	.inp2:active {background:#F6F6F6;}
	#img1 {
		width:30px;
		padding:5px;
		border:2px solid #FD9F28;
		border-radius:3px;
	}
	.tr1 td, .tr2 td {padding:0 45px;}
</style>
<script>
function deleteCheck(){
	var result = confirm("선택하신 상품을 삭제하시겠습니까?")
	if(result){
		location.href='delete?id=${item.itemid}'
	}
}
</script>
</head>
<body>
<div id="dv1">
<h2 id="title-action">상품 삭제 전 확인</h2>
<div id="dv2"><img src="../imgitem/${item.itemimg}"></div>
<div id="dv3">
<table class="t1">
	<tr><th colspan="2"><h2>${item.itemname}</h2></th></tr>
	<tr><td colspan="2"><hr></td></tr>
	<tr><td width="23%" class="td1">짧은 소개 </td>
		<td width="77%" class="td2">${item.shortdes}</td></tr>
   	<tr><td width="23%" class="td1">가격 </td>
   		<td width="77%" class="td2" style="font-weight:bolder">${item.price}원</td></tr>
   	<tr><td width="23%" class="td1">남은 수량 </td>
   		<td width="77%" class="td2">${item.stock}개</td></tr>
   	<tr><td colspan="2"><form action="../cart/cartAdd">
      	<input type="hidden" name="itemid" value="${item.itemid}">
        	<table class="t2">
          		<tr><td colspan="2" class="td3">
          			<!-- <input type="button" value="상품삭제" onclick="location.href='delete?id=${item.itemid}'"> -->
          			<input type="button" value="상품삭제" onclick="javascript:deleteCheck();" class="inp1">
       				<input type="button" value="상품목록" onclick="location.href='list'" class="inp2">
          		</td></tr>
          	</table></form>
      </td></tr>
</table>
</div></div>