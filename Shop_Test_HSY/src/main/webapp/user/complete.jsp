<%@page import="shop.dto.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Shop</title>
	<jsp:include page="/layout/meta.jsp" /> <jsp:include page="/layout/link.jsp" />
</head>
<body>   
	<% String root = request.getContextPath(); %>
	
	<jsp:include page="/layout/header.jsp" />
	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">회원 정보</h1>
	</div>
	<!-- 회원 가입/수정/탈퇴 완료 -->
	<div class="container mb-5 text-center">
		<h2 class="text-body-emphasis">
			<c:set var="msg" value="${param.msg}"></c:set>
			<c:choose>
				<c:when test="${msg == '0'}"></c:when>
				<c:when test="${msg == '1'}">회원 가입이 완료되었습니다.</c:when>
				<c:when test="${msg == '2'}">회원 정보가 수정되었습니다.</c:when>
				<c:when test="${msg == '3'}">회원 탈퇴가 완료되었습니다.</c:when>
			</c:choose>
		</h2>
		<p>
			<a href="<%= root %>" class="btn btn-primary mt-3">메인 화면</a>
		</p>
	</div>
	
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>







