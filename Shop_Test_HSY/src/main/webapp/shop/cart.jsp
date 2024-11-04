<%@page import="shop.dao.ProductRepository"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Shop</title>
	<jsp:include page="/layout/meta.jsp" />
	<jsp:include page="/layout/link.jsp" />
</head>
<body>   
	<% String root = request.getContextPath(); 
		
		String loginId = (String) session.getAttribute("loginId");
		List<Product> productList;
		
		if (loginId != null) {
			productList = (List<Product>) session.getAttribute(loginId);
		}
		else {
			productList = (List<Product>) session.getAttribute("user");
		}
	%>
	
	<jsp:include page="/layout/header.jsp" />
	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">장바구니</h1>
		<div class="col-lg-6 mx-auto">
			<p class="lead mb-4">장바구니 목록 입니다.</p>
		</div>
	</div>
	
	<!-- 장바구니 영역 -->
	<div class="container order">
		<!-- 장바구니 목록 -->
		<table class="table table-striped table-hover table-bordered text-center align-middle">
			<thead>
				<tr class="table-primary">
					<th>상품</th>
					<th>가격</th>
					<th>수량</th>
					<th>소계</th>
					<th>비고</th>
				</tr>
			</thead>
			<tbody>
				<%
					if (productList != null && !productList.isEmpty()) {
						int total = 0;
						for (Product product : productList) {
							int subtotal = product.getUnitPrice() * product.getQuantity();
							total += subtotal;
				%>
 				<tr>
 					<td><%= product.getName() %></td>			
 					<td><%= product.getUnitPrice() %></td>			
 					<td><%= product.getQuantity() %></td>			
 					<td><%= subtotal %></td>			
 					<td><a href="deleteCart.jsp?id=<%=product.getProductId() %>" class="btn btn-sm btn-danger">삭제</td>			
 				</tr>
				<%
					}
				%>	
				<tr>
					<td colspan="1">
					<td colspan="1">
					<td colspan="1" class="text-center align-middle"><strong>총액</strong></td>
					<td colspan="1"><%= total %></td>
					<td colspan="1">
				</tr>
				<%
					} else {
				%>
			</tbody>
			<tfoot>
				
				<tr>
					<td colspan="5">추가된 상품이 없습니다.</td>	
				</tr>
				
			</tfoot>
			<%
				}
			%>
		</table>
	
		<!-- 버튼 영역 -->
		<div class="d-flex justify-content-between align-items-center p-3">
			<a href="deleteCart.jsp?cartId=57A47AE6CF1DBC2ABFC12D2959B51DD8" class="btn btn-lg btn-danger ">전체삭제</a>

			<a href="<%= root %>/shop/ship.jsp" class="btn btn-lg btn-primary" onclick="order()">주문하기</a>
		</div>
	</div>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>





