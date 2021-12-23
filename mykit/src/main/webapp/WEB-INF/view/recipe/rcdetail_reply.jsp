<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- /WEB-INF/view/recipe/rcdetail.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>밀키트 데뷔전 상세보기</title>
<style>
	table {
		width: 60%;
		table-layout:fixed:word-break:break-all;
	}
	td {
		padding: 10px;
	}
</style>
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
</script>
</head><body>
<br><h3 id="board-title">밀키트 데뷔전</h3><br><br>
<table border="1">
	<tr><td width="10%">제목</td>
		<td colspan="3" align="left">${recipe.rctitle}</td>
		<td width="20%" align="right"><fmt:formatDate value="${recipe.rcdate}" pattern="yyyy-MM-dd HH:mm:ss"/></td></tr>
	<tr><td>작성자</td>
		<td width="10%" align="left">${recipe.userid}</td>
		<td colspan="2" align="center">👀 ${recipe.rcreadcnt}&nbsp;💬 10개&nbsp;♥ 10개</td>
		<td width="10%" align="center"><input type="button" value="좋아요">&nbsp;<input type="button" value="공유" onclick="url_copy();"></td>
	<tr><td>내용</td>
		<td colspan="4" class="leftcol">
			<table class="lefttoptable">
				<tr><td align="left">${recipe.rccontent}</td></tr>
			</table>
		</td></tr>	
	<tr><td colspan="5" align="center">
		<%-- 수정버튼/삭제버튼 관리자 로그인시 or 작성자로그인시만 보임 --%>
        <c:if test="${(sessionScope.loginUser.userid eq 'admin') || (sessionScope.loginUser.userid eq recipe.userid) }">
			<a href="rcupdate?rcnum=${recipe.rcnum}">[수정]</a>
			<a href="rcdelete?rcnum=${recipe.rcnum}">[삭제]</a>
		</c:if>
		<a href="rclist">[목록]</a></td>
	</tr>
</table>
<table border="1">
	<caption>댓글[💬 0개]</caption>
	<tr><td colspan="4">댓글입력창</td>
		<td width="20%" align="center">[입력]</td></tr>
	<tr><td>1</td>
		<td colspan="3" align="left">맛있어보여용ㅇ~~~</td>
		<td align="center">[수정][삭제]</td></tr>
	<tr><td colspan="5" align="center">더보기</td></tr>
</table>
</body></html>