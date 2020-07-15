<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>
	페이지 디렉티브
	page : jsp 설정 정보와 import 하는 것	
	include : 현재 jsp 페이지에서 다른 jsp 페이지를 포함
	taglib : el, jstl 서블릿 기반에서 사용하기 때문에 <!-- ${ } --> 을 사용하면서 소스가 줄여준다.
	
	<!-- jsp -> java -> class 변환 : 서블릿 파일 -->
</div>
<h1>jsp 구문으로 (주소줄에) request</h1>
<%

	String aparam = request.getParameter("a");
	String bparam = request.getParameter("b");
	
	out.println("aparam = " + aparam);
	out.println("bparam = " + bparam);

%>

<h1>el, jstl태그</h1>
${param.a}
${param.b}
</body>
</html>