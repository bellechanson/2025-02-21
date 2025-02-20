<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
	// 세션 체크
	String userid = (String)session.getAttribute("userid");
	if(userid == null){
		response.sendRedirect("login.jsp");
	}
	
	// DB 연결 정보
	String jdbcUrl = "jdbc:mysql://localhost:3309/spring5fs";
	String dbUser = "root";
	String dbPassword  = "1234";
	Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    Connection songConn = null;
    PreparedStatement songPstmt = null;
    ResultSet songRs = null;
	
    String name = "";
    String email = "";
    
    try{
    	Class.forName("com.mysql.cj.jdbc.Driver");
    	conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
    	
    	// DB 연결 체크!!!
    	if (conn == null) {
            throw new SQLException("DB 연결 실패! JDBC URL을 확인하세요.");
        }
    	
    	// 로그인한 사용자의 정보 가져오기 !!!!!!!!!!
    	String sql = "select name, email from users where userid = ?";
    	pstmt = conn.prepareStatement(sql);
    	pstmt.setString(1, userid);
    	rs = pstmt.executeQuery();
    	
    	if (rs.next()) {
    		name = rs.getString("name");
    		email = rs.getString("email");
    	}
    } catch (Exception e){e.printStackTrace();}
    //finally{ 
    	
    //}
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>메인 페이지</title>
	<style>
		.container{
			width : 800px;
			margin : 50px auto;
			padding : 20px;
		}
		.header {
			display : flex;
			justify-content : space-between;
			align-items : center;
			margin-bottom : 20px;
		}
		.logout-btn {
			padding: 8px 15px;
            background: #dc3545;
            color: white;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            cursor: pointer;
            transition: 0.3s;
		}
		 .logout-btn:hover {
            background: #c82333;
        }
        .user-info {
            margin-bottom: 20px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 5px;
        }
	</style>
</head>
<body>

	<div class="container">
		<div class="header">
			<h2>환영합니다, <%= name %>님!</h2>
			<a href="logout.jsp" class="logout-btn">로그아웃</a>
		</div>
		<div class="user-info">
            <p><strong>아이디:</strong> <%= userid %></p>
            <p><strong>이메일:</strong> <%= email %></p>
        </div>
		<div class="content">
			<p>이곳은 로그인된 사용자만 접근할 수 있는 페이지입니다.</p>
		</div>
	</div>
	
	<div class="songs">
		<h3>🎵 노래 목록</h3>
		<ul>
			<%
			try{
				songConn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
				String songsql = "SELECT id, title, artist, genre FROM songs";
				songPstmt = songConn.prepareStatement(songsql);
                songRs = songPstmt.executeQuery();
                
                while(songRs.next()){
			%>
				<li>
					<a href="song.jsp?id=<%= songRs.getInt("id") %>">
						<strong><%= songRs.getString("title") %></strong> 
				    </a>- <%= songRs.getString("artist") %> (<%= songRs.getString("genre") %>)
				</li>
			<%
                }
			}catch (Exception e) {
                e.printStackTrace();
            } 
			%>
		</ul>

</body>
</html>