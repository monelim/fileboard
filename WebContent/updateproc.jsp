<%@ page import="com.mh.file.FileBoardDTO"%>
<%@ page import="com.mh.file.FileBoardDAO"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="java.io.File"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	FileBoardDTO fdto = new FileBoardDTO(); 
	
	int maxsize = 1024*1024*10; 
	String filepath = application.getRealPath("/upload/"); //application을 이용하면 강제적으로 경로를 생성함, 다른 폴더로 변경시 ex) "d:/a/"

	File file = new File(filepath); // file 객체 생성
	
	if( !file.exists() ){ // file이 존재하지 않으면 
		file.mkdirs(); // file을 만들어라. mkdirs : 디렉토리 만들어라.
	}

	MultipartRequest mr = new MultipartRequest(
			request,
			filepath,
			maxsize,
			"utf-8",
			new DefaultFileRenamePolicy()
			);
	
	Enumeration<?> params = mr.getParameterNames(); // 변수가 가진 객체들을 저장해야 하므로 콜렉션인 Enumeration 타입 사용
	
	while(params.hasMoreElements()){
		String name = (String) params.nextElement();
		String value = mr.getParameter(name);
		
		out.println("name = " + name + " value = " + value + "<br/>");
	}
	
	Enumeration<?> enums = mr.getFileNames();
	
	while( enums.hasMoreElements() ){
		String name = (String) enums.nextElement();
		
		// 서버 쪽 이름
		String serverfilename = mr.getFilesystemName(name);
		// 클라이언트 쪽 이름
		String clientfilename = mr.getOriginalFileName(name);
		
		String type = mr.getContentType(name);
		
		File cfile = mr.getFile(name);
		
		out.println("파라메터 이름 : " + name + "<br/>");
		out.println("서버 이름 : " + serverfilename + "<br/>");
		out.println("클라이언트 이름 : " + clientfilename + "<br/>");
		out.println("파일 크기: " + cfile.length() + "<br/>");
		
		fdto.setIdx( Integer.parseInt( mr.getParameter("idx")) );
		fdto.setFilename(serverfilename);
		fdto.setTitle(mr.getParameter("title"));
		fdto.setContent(mr.getParameter("content"));
	}
	
	FileBoardDAO fbd = FileBoardDAO.getInstance();
	fbd.updateFileBoard(fdto);
	
	response.sendRedirect("index.jsp"); //다 진행하고 나면 index.jsp로 이동해라.



%>
