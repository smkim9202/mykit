<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<%-- /WEB-INF/view/exception.jsp 
	isErrorPage="true": 오류페이지로 설정, exception 내장객체 전달
	exception 내장객체: exception.**Exception이 할당됨.
--%>
<script>
	alert("${exception.message}")
	location.href="${exception.url}"
</script>
<%System.out.println(exception.getMessage());%>