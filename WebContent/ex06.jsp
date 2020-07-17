<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 3가지의 사용방법 -->
<%!
	String a = "a";
	public void doA() {
		System.out.println("a = " + a);
	}
%>	<!-- 클래스 영역에 빠지는 부분 -->
<%
	String b = "b";
%> <!-- jspservice로 자동으로 생성(ex06_jsp.java참조) -->
<%=a %>
<%=b %>
<% doA(); %> <!-- jspservice로 자동으로 생성 -->

</body>
</html>