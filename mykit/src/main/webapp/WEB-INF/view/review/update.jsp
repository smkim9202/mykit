<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%-- /webapp/WEB-INF/view/review/update.jsp --%>    
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="../css/fonts.css" rel="stylesheet">
<title>리뷰 수정</title>
<style type="text/css">
	* {margin: auto;}
	#dv1 {
		position:relative;
		width:1180px;
		margin:0 10px 100px 10px;
	}
	h3 {margin-top:30px;}
	hr {margin: 10px 0;}
	th {text-align:left;}
	th, td {
		padding:5px;
		font-size:15px;
	}
	#dv2 {margin-top:15px;}
	#dv2 a {
		color: #ffffff;
		background-color: #FD9F28;
		border-color: #FD9F28;
		margin:0 3px;
		text-decoration:none;
		font-size:13px;
		padding:2px 10px;
		border-radius:3px;
	}
	#dv2 a:active {
		background-color:#ED9525;
		font-weight:bolder;
	}
</style>
</head>
<body>
<div id="dv1">
<form:form modelAttribute="review" action="update" enctype="multipart/form-data" name="updateform">
<form:hidden path="userid"/><form:hidden path="itemid"/><form:hidden path="renum"/>
	<h3 id="review-title">리뷰 수정</h3>
	<table>
		<tr><td colspan="4"><hr></td></tr>
		<tr>
			<th>아이디</th><td><form:input path="userid" readonly="true"/></td>
			<th>상품번호</th><td><form:input path="itemid" readonly="true"/></td>
		</tr>
		<tr>
			<th>점수입력</th><td colspan="3"><form:input type="number" path="score" min="1" max="5"/>
			<font color="red"><form:errors path="score"/></font></td>
		</tr>
		<tr>
			<td colspan="4"><form:textarea path="recontent" rows="20" cols="70"/>
			<script type="text/javascript" >
				CKEDITOR.replace("recontent", { filebrowserImageUploadUrl : "imgupload" });
    		</script>
			<font color="red"><form:errors path="recontent"/></font></td>
		</tr>
	</table>
	<div id="dv2">
		<a href="javascript:document.updateform.submit()">리뷰 수정</a>
		<a href="list?id=${sessionScope.loginUser.userid}">리뷰 목록</a>
		<a href="../user/myitemlist?id=${sessionScope.loginUser.userid}">구매 목록</a>
	</div>
</form:form>
</div>
</body>
</html>