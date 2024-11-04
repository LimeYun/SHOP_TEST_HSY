<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Product"%>
<%@page import="shop.dao.ProductRepository"%>
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
	ProductRepository productRepository = new ProductRepository();

	String loginId = (String) session.getAttribute("loginId");
	String productId = request.getParameter("id");
	
	Product product = productRepository.getProductById(productId);
	
	List<Product> productList = null;
	
	if (loginId != null) {
		productList = (List<Product>) session.getAttribute(loginId);
	}
	else {
		productList = (List<Product>) session.getAttribute("user");
	}
	
	if (productList == null) {
		productList = new ArrayList<>();
	}
	
	boolean check = false;
	for (Product p : productList) {
		if (p.getProductId().equals(productId)) {
			p.setQuantity(p.getQuantity() + 1);
			check = true;
			break;
		}
	}
	if (!check) {
		product.setQuantity(1);
		productList.add(product);
	}
	
	
	if (loginId != null) {
		session.setAttribute(loginId, productList);
	}
	else {
		session.setAttribute("user", productList);
	}
	
	session.setAttribute("cartMessage", "상품이 장바구니에 추가되었습니다.");
	
	response.sendRedirect(root + "/shop/products.jsp");
%>
</body>
</html>