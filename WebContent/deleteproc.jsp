<%@page import="com.mh.file.FileBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
deleteproc.jsp
<%
	String[] cks = request.getParameterValues("ck"); // getParameterValues -> String[] : String 배열로 리턴, 주로 checkbox에서 사용

//	for(int i = 0; i < cks.length; i++) {
//		out.println(cks[i]);
//	}

	FileBoardDAO dao = FileBoardDAO.getInstance();
	dao.deleteFileBoard(cks); // FileBoardDAO의  deleteFileBoard 객체로 전달 ?
			
	response.sendRedirect("index.jsp");
	

%>
</body>
</html>