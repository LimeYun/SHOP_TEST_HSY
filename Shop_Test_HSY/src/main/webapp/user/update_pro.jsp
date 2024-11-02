<%@page import="shop.dao.UserRepository"%>
<%@page import="shop.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="userDAO" class="shop.dao.UserRepository" />
<%

	// 회원 정보 수정 처리
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	String birth = request.getParameter("year") + "-" + request.getParameter("month") + "-" + request.getParameter("day");
	String mail = request.getParameter("email1") + "@" + request.getParameter("email2");
	String phone = request.getParameter("phone");
	String address = request.getParameter("address");
	
	User user = new User();
	user = userDAO.getUserById(id);
	user.setName(name);
	user.setGender(gender);
	user.setBirth(birth);
	user.setMail(mail);
	user.setPhone(phone);
	user.setAddress(address);
	
	String root = request.getContextPath();
	

    int result = userDAO.update(user);
    
    if (result > 0){
        response.sendRedirect(root + "/user/complete.jsp?msg=2");
    } else {
        response.sendRedirect(root + "/update.jsp");
    }

%>
