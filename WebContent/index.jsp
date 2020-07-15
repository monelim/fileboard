<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 개발방법론? -->
<%@ page import="com.mh.file.FileBoardDAO" %>
<%@ page import="com.mh.file.FileBoardDTO" %>
<%
	FileBoardDAO dao1 = FileBoardDAO.getInstance(); // 생성(2), 싱글톤 생성시 아래의 기본생성자 생성을 막아야한다.
//	FileBoardDAO dao = new FileBoardDAO(); // dao 객체생성 -> index파일 업로드시 새로운 객체 계속 생성하여 메모리 낭비, 속도저하 : 싱글톤으로 해결 / 기본생성자가 public 이므로 생성 가능(1), private이면 생성 불가능

	List<FileBoardDTO> list = dao1.selectAllFileBoard(); //db의 자료를 select하면 resultset에 담아서 array list로 가져온다. 아래에서 그 내용을 뿌려야함.
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>

<form action="uploadproc.jsp" method="post" enctype="multipart/form-data"> <!--method = post : 주소줄에 나오는 내용 비용개  -->
	<h1>file upload</h1>
	<div>	
		제목<input type="text" name="title"/></br>
		내용<textarea name="content"></textarea></br>
		첨부<input type="file" name="file"/>
		<input type="submit" value="저장"/>
	</div>
</form>

<div>
	<table border="1">
		<tr>
			<th>idx</th>
			<th>title</th>
			<th>content</th>
			<th>file</th>
		</tr>
		<%
			for(int i = 0; i < list.size(); i++) {
				FileBoardDTO fdto = list.get(i);
				out.println("<tr>");
				out.println("<td>" + fdto.getIdx() + "</td>");
				out.println("<td>" + fdto.getTitle() + "</td>");
				out.println("<td>" + fdto.getContent() + "</td>");
				out.println("<td><img width=\"150\" src=\"/fileboard/upload/" + fdto.getFilename() + ".jpg\"/></td>"); // " 앞에 \붙여야 함.
				out.println("</tr>");
			}
		%>
		<!-- 
		<tr>
			<td>111</td>
			<td>222</td>
			<td>333</td>
			<td><img width="150" alt="" src="/fileboard/upload/444.jpg"/></td>
		</tr>
		 -->
	</table>
</div>

</body>
</html>