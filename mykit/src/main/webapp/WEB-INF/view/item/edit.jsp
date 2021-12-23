<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%-- /WEB-INF/view/item/edit.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<link rel="shortcut icon" type="image/x-icon" href="../img/logo.png">
<title>상품 수정</title>
<link href="../css/fonts.css" rel="stylesheet">
<style type="text/css">
	* {margin: auto;}	
	table {
		top:60px;
		position: relative;
		border: 1px solid #FD9F28;
		padding:30px 50px 30px 100px;
		margin-bottom:100px;
	}
	.itemtitle{
		color:#FD9F28;
	}
	th {
		float:left;
		margin-bottom:25px;
	}
	.td1 {
		color:#444444;
		padding-top:6px;
		text-align:center;
	}
	.td2 {width:300px;}
	.td3 {
		font-size:90%;
		padding-bottom:3px;
	}
	.td4 {padding-top:5px;}
	td input {margin-top:5px;margin-bottom:0;}
	.er {
		text-align:left;
		margin-left:5px;
		font-size:5px;
	}
	.in1 input {font-size:80%;}
	.in2 {text-align:center;}
	.in2 input {
		background-color:#FD9F28;
		border-radius:3px;
		border:none;
		color:white;
		width:70px;
		height:25px;
		margin:20px 3px 0 3px;
	}
	.in2 input:hover {cursor:pointer;}
	.in2 input:active {
		background-color:#ED9525;
		font-weight:bolder;
	}
</style>
<script type="text/javascript">
$(document).ready(function(){
	$("#rcnum").attr("value", 0);
    $("#rcnum").attr("disabled", true);
    $("input:radio[name=userpick]").click(function(){
    	if($("input[name=userpick]:checked").val() == "newitem"){
    		$("#rcnum").attr("value", 0);
            $("#rcnum").attr("disabled", true);
        }else if($("input[name=userpick]:checked").val() == "useritem"){
        	$("#rcnum").attr("disabled", false);
        }
    })
});
</script>
</head>
<body>
<form:form  modelAttribute="item" action="update" enctype="multipart/form-data">
	<form:hidden path="itemid"/><form:hidden path="itemimg"/><form:hidden path="description"/>
	<table>
	<tr><th><h2 class="itemtitle">상품 수정</h2></th></tr>
	<tr>
		<td class="td1">상품명</td>
		<td class="td2"><form:input path="itemname" maxlength="40" />
			<font color="red" class="er"><form:errors path="itemname" /></font></td>
	</tr>
	<tr>
		<td class="td1">상품 가격</td>
		<td><form:input path="price" maxlength="20" />
			<font color="red" class="er"><form:errors path="price" /></font></td>
	</tr>
   	<tr>
		<td class="td1">상품 이미지</td>
		<td class="in1"><input type="file" name="pictureimg"></td>
	</tr>
	<tr><td></td><td class="td3">${item.itemimg}</td></tr>
	<tr>
		<td class="td1">설명 이미지</td>
		<td class="in1"><input type="file" name="picturedes"></td>
	</tr>
	<tr><td></td><td class="td3">${item.description}</td></tr>
	<tr>
		<td class="td1">짧은 소개</td>
		<td><form:input path="shortdes" maxlength="1000" /></td>
	</tr>
	<tr>
		<td class="td1">분류</td>
		<td><select name="itype" style="width:100px;">
			<option value="">선택하시오</option>
			<option value="kor">한식</option>
			<option value="chn">중식</option>
			<option value="jpn">일식</option>
			<option value="wes">양식</option></select>
		<font color="red" class="er"><form:errors path="itype" /></font></td>
	</tr>
	<tr>
		<td class="td1">재고</td>
		<td><form:input type="number" path="stock" min="1" max="100"/></td>
	</tr>
	<tr>
		<td class="td1">추천/당선</td>
		<td class="td4"><label><input type="radio" name="userpick" value="newitem">&nbsp;추천 상품</label></td>
	</tr>
	<tr><td></td><td class="td4"><label><input type="radio" name="userpick" value="useritem">&nbsp;당선 상품</label></td></tr>
	<tr>
		<td></td>
		<td>
			<select name="rcnum" id="rcnum">
			<c:forEach items="${getUserItem}" var="uitem">
				<option><c:out value="${uitem}"/></option>
			</c:forEach>
			</select>
			<font color="red" class="er"><form:errors path="userpick" /></font>
		</td>
	</tr>
	<tr><td colspan="2" class="in2">
		<input type="submit" value="등록">
		<input type="button" value="취소" onclick="location.href='list'">
	</td></tr>
	</table>
</form:form>
</body>
</html>