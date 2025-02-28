<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    request.setCharacterEncoding("UTF-8");

    String userid = (String) session.getAttribute("userid");
    boolean isLoggedIn = (userid != null);

    String jdbcUrl = "jdbc:mysql://localhost:3309/portdb";
    String dbUser = "root";
    String dbPassword = "1234";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String name = "";
    String email = "";

    if (isLoggedIn) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            String sql = "SELECT name, email FROM users WHERE userid = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userid);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                name = rs.getString("name");
                email = rs.getString("email");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) {}
            if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
            if (conn != null) try { conn.close(); } catch (Exception e) {}
        }
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메인 페이지</title>
</head>
<body>

    <% if (isLoggedIn) { %>
        <a href="Login/logout.jsp">로그아웃</a>
        
        <div>
            <p><strong>아이디:</strong> <%= userid %></p>
            <p><strong>이메일:</strong> <%= email %></p>
        </div>
    <% } else { %>
        <a href="Login/login.jsp">[로그인]</a>
        <a href="signup.jsp">[회원가입]</a>  <!-- 로그인 상태일 때 회원가입 링크 추가 -->
    <% } %>
    
    <h3>🎵 노래 목록</h3>
    <button onclick="checkLogin('songs')">노래 목록 보기</button>  
    <div id="songList" style="display: none;">
        <ul>
            <% 
            try (Connection songConn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
                 PreparedStatement songPstmt = songConn.prepareStatement("SELECT id, title FROM songs");
                 ResultSet songRs = songPstmt.executeQuery()) {
                
                while(songRs.next()) { 
            %>
                <li>
                    <a href="song.jsp?id=<%= songRs.getInt("id") %>">
                        <%= songRs.getString("title") %>
                    </a>
                </li>
            <% 
                }
            } catch (Exception e) { 
                e.printStackTrace(); 
            }
            %>
        </ul>
    </div>

    <h3>📋 게시판 목록</h3>
    <a href="#" onclick="checkLogin('board')">게시글 작성</a>
    <table border="1">
        <thead>
            <tr>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
            </tr>
        </thead>
        <tbody>
            <% 
            try (Connection boardConn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
                 PreparedStatement boardPstmt = boardConn.prepareStatement("SELECT id, title, writer, created_at FROM board");
                 ResultSet boardRs = boardPstmt.executeQuery()) {
                
                while(boardRs.next()) { 
            %>
                <tr>
                    <td><a href="Board/Board_View.jsp?id=<%= boardRs.getInt("id") %>"><%= boardRs.getString("title") %></a></td>
                    <td><%= boardRs.getString("writer") %></td>
                    <td><%= boardRs.getString("created_at") %></td>
                </tr>
            <% 
                }
            } catch (Exception e) { e.printStackTrace(); } 
            %>
        </tbody>
    </table>

    <script>
    function checkLogin(action) {
        var isLoggedIn = <%= isLoggedIn %>;

        if (!isLoggedIn) {
            alert("로그인 후 이용해주세요.");
            return;
        }

        if (action === "songs") {
            var songList = document.getElementById("songList");
            var button = document.querySelector("button");

            if (songList.style.display === "none") {
                songList.style.display = "block";
                button.textContent = "노래 목록 숨기기";  
            } else {
                songList.style.display = "none";
                button.textContent = "노래 목록 보기";  
            }
        } else if (action === "board") {
            window.location.href = "Board/Board_Write.jsp";
        }
    }
    </script>

</body>
</html>
