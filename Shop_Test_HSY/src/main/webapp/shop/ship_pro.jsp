<%@page import="shop.dto.Ship"%>
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
	<title></title>
</head>
<body>
	<%
		String root = request.getContextPath();	
	
		Ship ship = new Ship();
		String name = request.getParameter("name");
		String shippingDate = request.getParameter("shippingDate");
		String country = request.getParameter("country");
		String zipCode = request.getParameter("zipCode");
		String addressName = request.getParameter("addressName");
		String phone = request.getParameter("phone");
		
		ship.setShipName(name);
		ship.setDate(shippingDate);
		ship.setCountry(country);
		ship.setZipCode(zipCode);
		ship.setAddress(addressName);
		ship.setPhone(phone);
		
		session.setAttribute("ship", ship);
		response.sendRedirect(root + "/shop/ordr.jsp");
	%>
</body>
</html>