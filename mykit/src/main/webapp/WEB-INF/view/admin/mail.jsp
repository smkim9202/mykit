<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- /webapp/WEB-INF/view/admin/mail.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메일 보내기</title>
<link href="../css/fonts.css" rel="stylesheet">
<style type="text/css">
	* {margin: auto; font-family:'Nanum';}
	#dv1 {
		position:relative;
		width:900px;
		margin:0 10px 100px 10px;
	}
	h2 {margin-bottom:20px; font-family:'NanumBold';}
	#dv2 {margin:10px;}
	.s1 {margin:20px;}
	#bt1 {text-align:center;}
	hr {width:800px; margin:5px 0;}
	th {text-align:left;}
	th, td {
		padding:5px;
		font-size:15px;
	}
	#bt1 input {
		margin:10px 5px 0 5px;;
		background-color:#FD9F28;
		border-radius:3px;
		border: none;
		color: white;
		padding:3px 8px;
	}
	#bt1 input:hover {
		cursor:pointer;
	}
	#bt1 input:active {
		background-color:#ED9525;
		font-weight:bolder;
	}
	.f input {font-size:12px;}
</style>
<script type="text/javascript">
   function idinputchk(f) {
	   if(f.naverid.value == "") {
		   alert("네이버 아이디를 입력하세요");
		   f.naverid.focus();
		   return false;
	   }
	   if(f.naverpw.value == "") {
		   alert("네이버 비밀번호를 입력하세요");
		   f.naverpw.focus();
		   return false;
	   }
	   return true;
   }
</script>
</head>
<body>
<div id="dv1">
<h2>메일 보내기</h2>
<hr>
<form name="mailform" method="post" action="mail" enctype="multipart/form-data" onsubmit="return idinputchk(this)">
<div id="dv2">
   <span class="s1">본인 네이버 ID : <input type="text" name="naverid" placeholder="@ 이전까지만 써주십시오"></span>
   <span class="s1">본인 네이버 비밀번호 : <input type="password" name="naverpw"></span>
</div>
<hr>
<table>
 <tr>
 	<th>보내는 사람</th>
 	<td>${loginUser.username}</td>
 </tr>
 <tr>
 	<th>받는 사람</th>
 	<td><input type="text" name="recipient" size="100"
 	value='<c:forEach items="${list}" var="user">${user.username} &lt;${user.email}&gt;,</c:forEach>'>
 	</td>
 </tr>
 <tr>
 	<th>제목</th>
 	<td><input type="text" name="title" size="100"></td>
 </tr>
 <tr>
 	<th>메시지 형식</th>
 	<td>
 		<select name="mtype">
       		<option value="text/html; charset=utf-8">HTML</option>
       		<option value="text/plain; charset=utf-8">TEXT</option>
       	</select>
    </td>
 </tr>
 <tr>
 	<th>첨부파일1</th>
 	<td class="f"><input type="file" name="file1"></td>
 </tr>
 <tr>
 	<th>첨부파일2</th>
 	<td class="f"><input type="file" name="file1"></td>
 </tr>
 <tr><td colspan="2"><hr></td></tr>
 <tr><td colspan="2"><textarea name="contents" cols="120" rows="10"></textarea>
  <script>CKEDITOR.replace("contents")</script></td>
 </tr>
 <tr><td colspan="2" id="bt1"><input type="submit" value="전송"><input type="button" value="취소" onclick="location.href='../admin/list'"></td></tr>
</table>
</form>
</div>
</body>
</html>