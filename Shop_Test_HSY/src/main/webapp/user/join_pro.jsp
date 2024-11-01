<!-- 
	회원 가입 처리
 -->
<%@page import="shop.dao.UserRepository"%>
<%@page import="shop.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String id = request.getParameter("id");
	String password = request.getParameter("pw");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	String birth = request.getParameter("year") + "-" + request.getParameter("month") + "-" + request.getParameter("day");
	String mail = request.getParameter("mail1") + "@" + request.getParameter("mail2");
	String phone = request.getParameter("phone");
	String address = request.getParameter("address");

	User user = new User();
	user.setId(id);
	user.setPassword(password);
	user.setName(name);
	user.setGender(gender);
	user.setBirth(birth);
	user.setMail(mail);
	user.setPhone(phone);
	user.setAddress(address);
	
	String root = request.getContextPath();
	
	UserRepository userRepository = new UserRepository();
	int msg = userRepository.insert(user);
	
	if (msg > 0){		
		response.sendRedirect(root + "/user/complete.jsp?msg=1");
	}
	else {
		response.sendRedirect(root + "/user/join.jsp");
	}
	
%>
    
    

    
    
    
    
    
    