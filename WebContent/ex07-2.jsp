<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		request.setCharacterEncoding("UTF-8"); // 한글이 깨지면 설정 꼭 해주기!
		String aa = request.getParameter("aa");
	%>
	<%=aa %>

</body>
</html>