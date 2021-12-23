<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- /WEB-INF/view/user/pwsearch.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image/x-icon" href="../img/logo.png">
<title>비밀번호 찾기</title>
<link href="../css/fonts.css" rel="stylesheet">
<style type="text/css">
	table {
		top:70px;
		float:left;
		position: absolute;
		padding-left:30px;
	}
	h3 {
		float:left;
		margin-left:20px;
		margin-bottom: 20px;
	}
	.td1 {text-align:center; color:#444444;}
	.td2 {width:100px;}
	td {padding:5px 0;}	
	.td2 input {
		border-radius:3px;
		border: 1px solid #FD9F28;
		margin-left:10px;
		margin-right:5px;
		height:20px;
	}
	.td2 input:focus {
		outline:1px solid #FD9F28;
	}
	.sb {text-align:center;}
	.sb input {
		height:25px;
		background-color:#FD9F28;
		border-radius:3px;
		border: 1px solid #FD9F28;
		color: white;
	}
	.sb input:hover {
		cursor:pointer;
	}
	.sb input:active {
		background-color:#ED9525;
		font-weight:bolder;
	}
	a:visited {color:#FD9F28;}
	.er {width:200px;}
</style>

<script>
function send(frm){
	frm.action = 'pwsend';
	frm.submit();
	return true;
}
</script>
</head>
<body>
<h3 id="user-name">비밀번호찾기</h3>
<form:form modelAttribute="user" action="pwsearch" method="post">

  <spring:hasBindErrors name="user">
    <font color="red">
    	<c:forEach items="${errors.globalErrors}" var="error">
         	<spring:message code="${error.code}" />
      	</c:forEach>
    </font>
  </spring:hasBindErrors>
  
  <table>
	 <tr><td class="td1">아이디</td><td class="td2"><input type="text" name="userid"></td>
		<td class="er"><font color="red"><form:errors path="userid"/></font></td></tr>
  
	 <tr><td class="td1">이메일</td><td class="td2"><input type="text" name="email"></td>
		<td class="er"><font color="red"><form:errors path="email"/></font></td></tr>
		
	 <tr><td class="td1">전화번호</td><td class="td2"><input type="text" name="phoneno"></td>
		<td class="er"><font color="red"><form:errors path="phoneno"/></font></td></tr>
		
	 <tr><td colspan="2" class="sb"><input type="submit" value="비밀번호 찾기"></td><td></td></tr>
	 <tr><td class="user-info" colspan="3">이메일 전송을 원하시면 <a class="user-special" href ="pwsend">여기</a>를 눌러주세요</td></tr>
  </table>
</form:form>
</body>
</html>