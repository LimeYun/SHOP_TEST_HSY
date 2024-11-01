<!-- 로그인 처리 -->
<%@page import="shop.dto.PersistentLogin"%>
<%@page import="java.util.UUID"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="shop.dto.User"%>
<%@page import="shop.dao.UserRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String root = request.getContextPath();

	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	UserRepository userDAO = new  UserRepository();
	User loginUser = userDAO.login(id, pw);
	
	// 로그인 실패
	if (loginUser == null) {
		response.sendRedirect(root + "/user/login.jsp?error=0");
		return;
	}
	// 로그인 성공
	// - 세션에 아이디 등록
	if (loginUser != null) {
		// 세션에 사용자 정보 등록
		session.setAttribute("loginId", loginUser.getId());
		session.setAttribute("loginUser", loginUser);
	}
	// 아이디 저장
	String rememberId 		= request.getParameter("remember-id");
	Cookie cookieRememberId = new Cookie("rememberId","");
	Cookie cookieUserId		= new Cookie("userId","");
	
	
	if (rememberId != null && rememberId.equals("on")) {
		// 쿠키 생성
		cookieRememberId.setValue(URLEncoder.encode(rememberId,"UTF-8"));
		cookieUserId.setValue(URLEncoder.encode(id,"UTF-8"));
	}
	// 아이디 저장 체크 해제 시
	else {
		// 쿠키 삭제 - 쿠키 유효시간을 0으로 하고 응답
		cookieRememberId.setMaxAge(0);
		cookieUserId.setMaxAge(0);
	}
	
	// 자동 로그인
	String rememberMe = request.getParameter("remember-me");
	Cookie cookieRememberMe = new Cookie("rememberMe", "");
	Cookie cookieToken = new Cookie("token", "");
	
	cookieRememberMe.setPath("/");
	cookieToken.setPath("/");
	
	cookieRememberMe.setMaxAge(60*60*24*3);
	cookieToken.setMaxAge(60*60*24*3);
	
	if (rememberMe != null && rememberMe.equals("on")) {
		// 자동 로그인 체크 시
		// - 토큰 발행
		String refreshToken = userDAO.refreshToken(id);
		String token = null;
		if (refreshToken != null) {
			token = refreshToken;
		}
		// - 쿠키 생성
		cookieRememberMe.setValue(URLEncoder.encode(rememberMe, "UTF-8"));
		cookieToken.setValue(URLEncoder.encode(token, "UTF-8"));
	}
	else {
		// 자동 로그인 미체크 시
		// 쿠키 삭제
		cookieRememberMe.setMaxAge(0);
		cookieToken.setMaxAge(0);
	}
	
	// 쿠키 전달
	response.addCookie(cookieRememberId);
	response.addCookie(cookieUserId);
	response.addCookie(cookieRememberMe);
	response.addCookie(cookieToken);
	
	// 로그인 성공 페이지로 이동
	response.sendRedirect(root + "/user/complete.jsp?msg=0");		

%>





