<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 개발방법론? -->
<%@ page import="com.mh.file.FileBoardDAO" %>
<%@ page import="com.mh.file.FileBoardDTO" %>
<%

//	String requestAttribute = (String) request.getAttribute("a");
//	out.println("requestAttribute = " + requestAttribute + "<br/>");
	
//	String sessionAttribute = (String) session.getAttribute("b");
//	out.println("sessionAttribute = " + sessionAttribute + "<br/>");
//	=============================================================================================


	FileBoardDAO dao1 = FileBoardDAO.getInstance(); // 생성(2), 싱글톤 생성시 아래의 기본생성자 생성을 막아야한다.
//	FileBoardDAO dao = new FileBoardDAO(); // dao 객체생성 -> index파일 업로드시 새로운 객체 계속 생성하여 메모리 낭비, 속도저하 : 싱글톤으로 해결 / 기본생성자가 public 이므로 생성 가능(1), private이면 생성 불가능

	List<FileBoardDTO> list = dao1.selectAllFileBoard(); //db의 자료를 select하면 resultset에 담아서 array list로 가져온다. 아래에서 그 내용을 뿌려야함.
%>
<!-- 
<br/>
<br/>
${a}
<br/>
${b}
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){  // document 문서가 이 페이지에 다 들어오면 실행해라?
//	alert("경고창 출력");
	$(".row").on("click", function(){
//		alert("행 누름");
		var idx = $(this).find("td").eq(1).html(); // val() : 테그 값, text() : html을 제거하고 값만, html() > 값 가져오는 함수
		var title = $(this).find("td").eq(2).html();
		var content = $(this).find("td").eq(3).html();
		
		console.log("idx = " + idx);
		console.log("title = " + title);
		console.log("content = " + content);
		
		$("#idx").val(idx);
		$("#title").val(title);
		$("#content").val(content);
	})
}) 
</script>
</head>

<body>

<!-- <1> 화면의 보여지는 내용을 폼에 기술. '저장' 버튼 클릭시 action 속성에 설정한 'uploadproc.jsp' 페이지로 입력한 값과 포르개므의 제어가 넘어간다. -->
<form action="uploadproc.jsp" method="post" enctype="multipart/form-data"> <!--method = post : 주소줄에 나오는 내용 비공개  -->
	<h1>file 저장</h1>
	<div>	
		제목<input type="text" name="title"/></br>
		내용<textarea name="content"></textarea></br>
		첨부<input type="file" name="file"/>
		<input type="submit" value="저장"/>
	</div>
</form>

<form action="updateproc.jsp" method="post" enctype="multipart/form-data">
	<h1>file 수정</h1>
	<div>
		idx <input type="text" name="idx" id="idx"/></br> <!-- idx -->
		제목<input type="text" name="title" id="title"/></br>
		내용<textarea name="content" id="content"></textarea></br>
		첨부<input type="file" name="file" id="file"/> 
		<input type="submit" value="수정"/>
	</div>
</form>

<div>
	<form action="deleteproc.jsp">
		<input type="submit" value="삭제"/>
		
	<table border="1">
		<tr>
			<th></th>
			<th>idx</th>
			<th>title</th>
			<th>content</th>
			<th>file</th>
		</tr>
		<%
			for(int i = 0; i < list.size(); i++) {
				FileBoardDTO fdto = list.get(i);
				out.println("<tr class=\"row\">");				
				out.println("<td><input type=\"checkbox\" name=\"ck\" value=\"" + fdto.getIdx() + "\"/></td>");
				out.println("<td>" + fdto.getIdx() + "</td>");
				out.println("<td>" + fdto.getTitle() + "</td>");
				out.println("<td>" + fdto.getContent() + "</td>");
				out.println("<td><img width=\"150\" src=\"/fileboard/upload/" + fdto.getFilename() + "\"/></td>"); // " 앞에 \붙여야 함.
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
	
	</form>
</div>

</body>
</html>