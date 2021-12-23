<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- /webapp/WEB-INF/view/user/userupdate.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image/x-icon" href="../img/logo.png">
<title>사용자 정보 수정</title>
<link href="../css/fonts.css" rel="stylesheet">
<style type="text/css">
	* {
		margin: auto;
	}
	
	table {
		top:10px;
		position: relative;
		border: 1px solid #FD9F28;
		padding:30px 100px 30px;
		margin-bottom:100px;
	}
	th {
		float:left;
		margin-bottom: 25px;
	}
	td {
		text-align:center;
	}
	div {
		height:10px;
		margin-top:10px;
		position:relative;
	}
	.er {
		text-align: left;
		padding:0 0 0 10px;
		height:20px;
		font-size:5px;
	}
	.td1 input {
		border-radius:3px;
		border: 1px solid #FD9F28;
		margin-left:10px;
		margin-right:5px;
		height:20px;
	}
	.td1 input:focus {
		outline:1px solid #FD9F28;
	}
	.bt1 input, .bt2 input {
		background-color:#FD9F28;
		border-radius:3px;
		border: none;
		color: white;
	}
	.bt1 input:hover, .bt2 input:hover {
		cursor:pointer;
	}
	.bt1 input:active, .bt2 input:active {
		background-color:#ED9525;
		font-weight:bolder;
	}
	.bt1 input {
		width:70px;
		height:23px;
		font-size:12px;
	}
	.bt2 input {
		width:70px;
		height:25px;
		margin-left:3px;
		margin-right:3px;
	}
	#a1 > img {
		margin-top:10px;
		height:100px;
	}
</style>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("address").value = extraAddr;
            
            } else {
                document.getElementById("address").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('zipcode').value = data.zonecode;
            document.getElementById("address").value = addr;
        }
    }).open();
}
</script>
</head>
<body>
<form:form modelAttribute="user" method="post" action="userupdate">
<center><a href="main" id="a1"><img alt="home" src="../img/mk.png" ></a></center>
  <spring:hasBindErrors name="user">
    <font color="red">
      <c:forEach items="${errors.globalErrors}" var="error">
        <spring:message code="${error.code}" />
      </c:forEach>
    </font>
  </spring:hasBindErrors>
  
  <table>
  	<tr><th><h3 id="user-name">사용자 정보 수정</h3></th></tr>
    <tr>
    	<td class="user-info">아이디</td>
    	<td class="td1"><form:input path="userid" readonly="true" /><td></td></tr><!-- 변경불가 -->
    <tr><td></td><td colspan="2" class="er"><font color="red"><form:errors path="userid" /></font></td>
    </tr>
    <tr>
    	<td class="user-info">비밀번호</td>
    	<td class="td1"><form:password path="userpw" /><td></td></tr>
    <tr><td></td><td colspan="2" class="er"><font color="red"><form:errors path="userpw" /></font></td>
    </tr>
    <tr>
    	<td class="user-info">이름</td>
    	<td class="td1"><form:input path="username" /><td></td></tr>
    <tr><td></td><td colspan="2" class="er"><font color="red"><form:errors path="username" /></font></td>
    </tr>
    <tr>
    	<td class="user-info">전화번호</td>
    	<td class="td1"><form:input path="phoneno" /><td></td></tr>
    <tr><td></td><td colspan="2" class="er"><font color="red"><form:errors path="phoneno" /></font></td>
    </tr>
    <tr>
    	<td class="user-info">우편번호</td>
    	<td class="td1"><form:input path="zipcode" /></td>
    	<td  class="bt1"><input type="button" onclick="sample6_execDaumPostcode()" value="우편번호"></td></tr>
    <tr><td></td><td colspan="2" class="er"><font color="red"><form:errors path="zipcode" /></font></td>
    </tr>
    <tr>
    	<td class="user-info">주소</td>
    	<td class="td1"><form:input path="address" /><td></td></tr>
    <tr><td></td><td colspan="2" class="er"><font color="red"><form:errors path="address" /></font></td>
    </tr>
    <tr>
    	<td class="user-info">이메일</td>
    	<td class="td1"><form:input path="email" /><td></td></tr>
    <tr><td></td><td colspan="2" class="er"><font color="red"><form:errors path="email" /></font></td>
    </tr>
    <tr>
    	<td class="user-info">생년월일</td>
    	<td class="td1"><form:input path="birth" /><td></td></tr>
    <tr><td></td><td colspan="2" class="er"><font color="red"><form:errors path="birth" /></font></td>
    </tr>
    <tr><td colspan="3" class="bt2">
       <input type="submit" value="수정">
       <input type="reset" value="초기화">
       <input type="button" value="취소" onclick="location.href='mypage?id=${sessionScope.loginUser.userid}'"></td>
    </tr>
  </table>
  </form:form>
  </body>
  </html>