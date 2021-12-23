<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- /WEB-INF/view/recipe/rcdetail.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>밀키트 데뷔전 상세보기</title>
<%-- font Awesome : 하트/공유이모티콘 --%>
<link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.css" rel="stylesheet"  type='text/css'>
<link href="../css/board.css" rel="stylesheet">
<script type="text/javascript">
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
	function noHeart(){
		alert("로그인 후 참여해주세요!")
	}
	function addHeart(rcnum){
		$.ajax({
			url : 'addHeart.do',
			type : 'get',
			data : {
				rcnum : rcnum
			}
		})
		alert("+1♥")
		window.location.reload()
	}
	function minusHeart(rcnum){
		$.ajax({
			url : 'minusHeart.do',
			type : 'get',
			data : {
				rcnum : rcnum
			}
		})
		alert("-1♥")
		window.location.reload()
	}

</script>

</head><body>
<h3 id="board-title">밀키트 데뷔전</h3>
<div class="detail">
<div class="tablewrap">
<table>
	<tr><th>제목</th>
		<td colspan="3" class="rcleft">&nbsp;${recipe.rctitle}</td>
		<td colspan="2"><fmt:formatDate value="${recipe.rcdate}" pattern="yyyy-MM-dd HH:mm:ss"/></td></tr>
	<tr><th>작성자</th><td>${recipe.userid}</td>
		<td colspan="2">👀 ${recipe.rcreadcnt}&nbsp;♥ ${recipe.heartcnt}</td>
		<td colspan="2"><span class="box">
						
						<%--좋아요버튼 --%>
						<c:if test="${heart==0}"><%--로그아웃, 하트 누르지 않았을때 --%>
							<c:if test="${sessionScope.loginUser.userid eq null}"><%--로그아웃일 때 --%>
								<input type="button" class="heart" value="&#xf004" onclick="noHeart();"></c:if>
							<c:if test="${sessionScope.loginUser.userid ne null}"><%--로그인유저가 하트 안눌렀을때  --%>
								<input type="button" class="heart" value="&#xf004" onclick="addHeart(${recipe.rcnum});"></c:if></c:if>
						<c:if test="${heart==1}"><%--로그인유저가 하트눌렀을때 --%>
						<input type="button" class="fullheart" value="&#xf004" onclick="minusHeart(${recipe.rcnum});"></c:if>

						&nbsp;<input type="button" class="share" value="&#xf064;" onclick="url_copy();"></span></td></tr>
	<tr><th>내용</th>
		<td colspan="5" class="content"><p>${recipe.rccontent}</p></td></tr>
	<tr><td colspan="6">
		  <%-- 수정버튼/삭제버튼 관리자 로그인시 or 작성자로그인시만 보임 --%>
		  <c:if test="${(sessionScope.loginUser.userid eq 'admin') || (sessionScope.loginUser.userid eq recipe.userid) }">
			<span class="box"><input type="button" value="수정" onclick="location.href='rcupdate?rcnum=${recipe.rcnum}'"></span>
			<span class="box"><input type="button" value="삭제" onclick="location.href='rcdelete?rcnum=${recipe.rcnum}'"></span>
		  </c:if>
		  	<span class="box"><input type="button" value="목록" onclick="location.href='rclist'"></span>
			</td></tr>
</table></div></div>
</body></html>