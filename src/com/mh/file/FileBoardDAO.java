package com.mh.file;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List; // ctrl + shift + o : import 자동정리 / c# ) ctrl + . : using 구문 완성 

public class FileBoardDAO {
	
	private static FileBoardDAO dao = new FileBoardDAO();
	
	public static FileBoardDAO getInstance() { // 싱글톤 반환
		return dao;
	}
	
	// DB 닫기 함수
	public void doClose(ResultSet rs, PreparedStatement pstmt, Connection conn) { // 함수로 만들어 호출하여 편리하게 사용하기위해 만듦.
		try {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}catch (Exception e) {
		
		}
	}
	
	// DB 연결 함수
	public Connection getConnection() { // 함수로 만들어 호출하여 편리하게 사용하기위해 만듦.
		
		Connection conn = null;
		
		try {
			Class.forName(CVALUES.sqlClass);
			conn = DriverManager.getConnection(CVALUES.sqlUrl, CVALUES.sqlUser, CVALUES.sqlPass);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	public void updateFileBoard(FileBoardDTO fdto) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("update fileboard " + "set title = ?, content = ? ,filename= ? " + "where idx = ? ");
			
			pstmt.setString(1, fdto.getTitle());
			pstmt.setString(2, fdto.getContent());
			pstmt.setString(3, fdto.getFilename());
			pstmt.setInt(4, fdto.getIdx());
			
			pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			doClose(null, pstmt, conn);
		}
	}
	
	// ex) cks[0] = 20, cks[1] = 21
	// cks.length는 2, i는 1
	public void deleteFileBoard(String[] cks) {
		
		String deleteIdxs = "";
		for(int i = 0; i < cks.length; i++) {
			if( i == cks.length - 1)
				deleteIdxs = deleteIdxs + " " + cks[i];
			else
				deleteIdxs = deleteIdxs + " " + cks[i] + ",";
		}
		System.out.println(deleteIdxs);
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("delete from fileboard " + " where idx in(" + deleteIdxs + ");");			
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			doClose(null, pstmt, conn); //resultset이 없기때문에 null
		}
	}
	
	public List<FileBoardDTO> selectAllFileBoard() { //selectAllFileBoard 호출해서 db의 자료를 select 하여 resultset에 담고 array list로 가져온다.
		
		List<FileBoardDTO> list = new ArrayList<FileBoardDTO>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from fileboard order by idx desc");
			rs = pstmt.executeQuery(); // resultset=rs는 하나의 테이블
			
			while (rs.next()) {
				//list.add(new FileBoardDTO(title, content, filename, idx)); //FileBoardDTO를 만들어 list에 넣어라. : (1) + (2) + (3)
				
				// (1)빈 객체 만들기
				FileBoardDTO fdto = new FileBoardDTO();
				
				// (2) 한 행의 내용
				fdto.setContent(rs.getString("content"));
				fdto.setTitle(rs.getString("title"));
				fdto.setFilename(rs.getString("filename"));
				fdto.setIdx(rs.getInt("idx"));
				
				// (3) list에 넣기
				list.add(fdto);
				
			}
		} catch (Exception e) {
		
		}
		finally {
			doClose(rs, pstmt, conn);
		}
		
		return list; // db에 저장된 ?행의 내용을 반환하게 된다.
	}
	
	public void insertFileBoard(FileBoardDTO dto) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int idx = 0;
		
		try {
			
			conn = getConnection(); // 아래 두 줄의 코드를 줄이기 위해 함수로 만들어 호출함.
			//Class.forName(CVALUES.sqlClass);
			//conn = DriverManager.getConnection(CVALUES.sqlUrl, CVALUES.sqlUser, CVALUES.sqlPass);
			
			System.out.println("dto = " + dto.toString());
			
			pstmt = conn.prepareStatement("exec PRO_SEQ 'FILE_BOARD_SEQ'");
			pstmt.setEscapeProcessing(true); // 프로시저 실행시 필요
			rs = pstmt.executeQuery();
			if(rs.next()) {
				idx = rs.getInt("value");
				System.out.println("idx = " + idx);
			}
			
			pstmt = conn.prepareStatement("insert into  fileboard " + 
					  "(title,content,filename,idx) " + 
					  "values " + 
					  "(?,?,?,?)");
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getFilename());
			pstmt.setInt(4, idx);			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			doClose(rs, pstmt, conn);
		}
	}

}
