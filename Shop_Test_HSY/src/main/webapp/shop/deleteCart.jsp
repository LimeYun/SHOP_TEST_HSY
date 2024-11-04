<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
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
	
		String loginId = (String) session.getAttribute("loginId");
		String productId = request.getParameter("id");
		
		List<Product> productList;
		
		if (loginId != null) {
			productList = (List<Product>) session.getAttribute(loginId);
		}
		else {
			productList = (List<Product>) session.getAttribute("user");
		}
		
		
		if (productList != null && productId != null) {
			for (Product product : productList) {
				if (product.getProductId().equals(productId)) {
					productList.remove(product); 
					break;
				}
			}
		}
		else {
			productList.clear();
		}
		
		
		if (loginId != null) {
			session.setAttribute(loginId, productList);
		}
		else {
			session.setAttribute("user", productList);
		}
		
		response.sendRedirect(root + "/shop/cart.jsp");
	%>
</body>
</html>