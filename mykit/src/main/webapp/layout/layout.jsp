<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- /WEB-INF/view/layout.jsp --%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<%-- <decorator:title />  : 원래 작성된 HTML 중 <title>태그의 내용  --%>
		<link rel="shortcut icon" type="image/x-icon" href="${path}/img/logo.png">
		<%-- <decorator:title />  : 원래 작성된 HTML 중 <title>태그의 내용  --%>
		<title><decorator:title /></title>
		<%-- CDN 방식으로 Jquery의 자바스크립트 파일 로드  --%>
		<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		<script type="text/javascript" src="http://cdn.ckeditor.com/4.5.7/standard/ckeditor.js"></script>
		<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
		<script type="text/javascript" src="js/main.js"></script>
		<script>
			function logoutCheck(){
				var result = confirm("로그아웃 하시겠습니까?")
				if(result){
					location.href='${path}/user/mainlogout'
				}
			}
		</script>
		<decorator:head />
		<link href="${path}/css/layout.css" rel="stylesheet" >

	</head>
	<body>
	<center>
	<div class="wrap"><!--상단 바까지의 영역-->
		<header>
			<div class="d1">
			<div class="search">
				<img src="${path}/img/search.png"/><input type="text" id="search1">
			</div>
			<a href="${path}/user/main"><div class="logo"><img src="${path}/img/logo.png" alt="mykit" /></div></a>
			<div class="top">
			<ul>
				<c:if test="${sessionScope.loginUser.userid == null}">
				<li><a href="${path}/user/userlogin">Login</a></li>
				</c:if>
				<c:if test="${sessionScope.loginUser.userid != null}">
				<li><a href="javascript:logoutCheck();">Logout</a></li>
				</c:if>
				<li class="l">|</li>
				<li><a href="${path}/user/mypage?id=${sessionScope.loginUser.userid}">MyPage</a></li>
				<li class="l">|</li>
				<li><a href="${path}/user/userentry">Join</a></li>
				<li class="l">|</li>
				<li><a href="${path}/cart/cartView">Cart</a></li>
			</ul>
		</div></div>
		</header>
		<div class="menu">
			<ul>
				<li><a href="${path}/item/list" class="main1"><img src="${path}/img/menu_icon.png"/>전체 상품</a>
					<ul class="sub1">
						<li><a href="${path}/item/list?itype=kor">한식 키트</a></li>
						<li><a href="${path}/item/list?itype=chn">중식 키트</a></li>
						<li><a href="${path}/item/list?itype=jpn">일식 키트</a></li>
						<li><a href="${path}/item/list?itype=wes">양식 키트</a></li>
					</ul>
				</li>
				<li><a href="${path}/item/list?userpick=newitem" class="main2">추천 상품</a></li>
				<li><a href="${path}/item/list?userpick=useritem" class="main3">당선 상품</a></li>
				<li><a href="${path}/recipe/rclist" class="main4">
				<span>밀</span><span>키</span><span>트</span>
				<span>데</span><span>뷔</span><span>전</span></a>
				</li>
				<li><a href="${path}/board/qalist" class="main5">고객센터</a>
	               <ul class="sub5">
	                  <li><a href="${path}/board/qalist">Q&A</a></li>
	                  <li><a href="${path}/board/faq">FAQ</a></li>
	                  <li><a href="${path}/board/evlist">공지&이벤트</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
	<decorator:body />
	
	<div id="ft">
		<img src="${path}/img/footer.jpg"/>
	</div>
	</center>
	</body>
	</html>