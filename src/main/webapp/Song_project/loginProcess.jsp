<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	// 사용자가 입력한 값 가져오기
	String userid = request.getParameter("userid");
	String password = request.getParameter("password");
	
	// DB 연결 정보
	String jdbcUrl = "jdbc:mysql://localhost:3309/spring5fs";
	String dbUser = "root";
	String dbPassword  = "1234";
	Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try {
    	Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

        String sql = "SELECT * FROM users WHERE userid = ? AND password = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userid);
        pstmt.setString(2, password);
        rs = pstmt.executeQuery();
        
    if(rs.next()){
    	// 로그인 성공 -> 세션 생성 후 main.jsp로 이동
    	 session.setAttribute("userid", userid);
    	 response.sendRedirect("main.jsp");
    } else{
    	// 로그인 실패 -> 다시 login.jsp로 이동 (에러 메시지 전달)    	
%>
			<script>
				alert("아이디 또는 비밀번호가 올바르지 않습니다.");
        		history.back();
			</script>
<%
		}
	} catch (Exception e){
	  e.printStackTrace();
%>
			<script>
            	alert("로그인 처리 중 오류가 발생했습니다.");
           		 history.back();
        	</script>
<%
	} finally {
		
	}
%>
	  
	  
	