<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%-- /webapp/WEB-INF/view/item/detail.jsp --%>    
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>  
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세 보기</title>
<link href="../css/fonts.css" rel="stylesheet">
<style type="text/css">
	* {margin: auto;}
	#dv1 {
		position:relative;
		width:1160px;
		margin:0 10px;
	}
	#dv2 {
		float:left;
		margin:10px 10px 20px 10px;
		width:550px;
		}
	#dv2 img {
		padding-left:10px;
		width:500px;}
	.t1 {
		position:relative;
		width:1100px;
	}
	#dv3 {
		float:right;
		margin-top:20px;
		margin-right:55px;
	}
	.t1 {width:535px;}
	.t1 th {
		text-align:left;
		padding: 10px 0 30px 5px;
	}
	.td1 {padding-left:15px;}
	.td1, .td2, .td3 {padding-top:35px;}
	.td2 {padding-right:15px;}
	.t2 {width:100%;}
	.td3 {padding-left:10px;}
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
	.td3 div {
		padding-top:16px;
		padding-right:8px;
		position:relative;
		float:right;
	}
	#img1 {
		width:20px;
		padding:5px;
		border:2px solid #FD9F28;
		border-radius:3px;
	}
	.t3 {
		width:1100px;
		margin:0 40px;
		top:40px;
		border-collapse:collapse;
		border-spacing:0;
	}
	.tr1 td, .tr2 td {padding:0 45px;}
	.tr2 td div img {margin-top:10px;}
	button {
		width:180px;
		height:55px;
		position:relative;
		color:#444444;
		border:1px solid #FD9F28;
		background:none;
		font-size:15px;
		border-top-left-radius: 5px;
		border-top-right-radius: 5px;
	}
	button:hover {cursor:pointer;}
	.clear {clear:both;}
	button.on {
		background-color:#FD9F28;
		color:white;
		font-weight:bolder;
	}
</style>
<script type="text/javascript">
$(function(){
	$("#btn1").click(function(){
		$("#reviewlist").empty();
		$("#detailbody").attr("src", "../imgitem/${item.description}");
	})
	$("#btn2").click(function(){
		$("#reviewlist").empty();
		$("#detailbody").attr("src", "../imgitem/delivery.png");
	})
	$("#btn3").click(function(){
		$("#reviewlist").empty();
		$("#detailbody").attr("src", "../imgitem/refund.jpg");
	})
	$("#btn4").click(function(){
		$("#detailbody").attr("src", "../imgitem/star.png");
		$.ajax({
			type:"GET",
			url:"../review/itemreview?id="+${item.itemid},
			dataType:"text",
			error:function(){
				alert("리뷰 목록 조회 오류");
			},
			success:function(data){
				$("#reviewlist").html(data);
			}
		});
	});
})
function url_copy(){
	var url = '';
	var textarea = document.createElement("textarea");
	document.body.appendChild(textarea);
	url = window.document.location.href;
	textarea.value = url;
	textarea.select();
	document.execCommand("copy");
	document.body.removeChild(textarea);
	alert("URL이 복사되었습니다.")
}

$(function() {
	$('button').click(function() {
		$('button').removeClass()
			$(this).addClass('on')
	})
})
</script>
</head>
<body>
<div id="dv1">
<div id="dv2"><img src="../imgitem/${item.itemimg}"></div>
<div id="dv3">
<table class="t1">
	<tr><th colspan="2">
		<c:if test="${item.stock == 0}">
			<h2 class="itemtitle" style="color:red;">${item.itemname} (품절)</h2>
		</c:if>
		<c:if test="${item.stock != 0}">
			<h2 class="itemtitle" style="color:#444444;">${item.itemname}</h2>
		</c:if>
	</th></tr>
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
        		<tr><td width="23%" class="td1">구매 수량 </td>
        			<td width="77%" class="td2">
	       				<select name="quantity">
	         					<c:forEach begin="1" end="10" var="i">
	           					<option>${i}</option>
	           				</c:forEach>
	           			</select>
            		</td></tr>
          		<tr><td colspan="2" class="td3">
          			<input type="submit" value="장바구니" class="inp1">
          			<input type="button" value="상품목록" onclick="location.href='list'" class="inp2">
          			<div><input type="image" name="button" src="../img/u_co.png" onclick="url_copy(); return false;" id="img1"></div>
          		</td></tr>
          	</table></form>
      </td></tr>
</table>
</div>
<table class="t3">
	<tr class="tr1">
		<td><button id="btn1" class="on">상세 정보</button>
			<button id="btn2">배송 안내</button>
		    <button id="btn3">반품 및 교환</button>
		  	<button id="btn4">리뷰</button></td>
	</tr>
	<tr><td><hr style="border:solid 1px #FD9F28; background:#FD9F28;"></td></tr>
	<tr class="tr2">
		<td colspan="3">
			<div>
				<img id="detailbody" src="../imgitem/${item.description}">
				<div id="reviewlist"></div>
			</div>
		</td>
	</tr>
</table>
</div>
</body>
</html>