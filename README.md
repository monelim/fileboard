# fileboard

20.07.15 -----------------------------

1) FileBoardDAO.java

public static FileBoardDAO getInstance() : <싱글톤, 캡슐화> 새로운 객체를 매번 생성하여 메모리 낭비, 속도저하를 방지하기 위함

public void doClose(ResultSet rs, PreparedStatement pstmt, Connection conn) : DB 닫기 함수
public Connection getConnection() : DB 연결 함수

public List<FileBoardDTO> selectAllFileBoard() : selectAllFileBoard 호출해서 db의 자료를 select 하여 resultset에 담고 array list로 가져온다.

2) index.jsp

List<FileBoardDTO> list = dao1.selectAllFileBoard(); : FileBoardDAO.java에서 저장한 db 가져온다



