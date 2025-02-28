<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // 로그인 여부 확인
    String userid = (String) session.getAttribute("userid");
    boolean isLoggedIn = (userid != null);

    // 게시글 ID 가져오기
    String boardId = request.getParameter("id");
    if (boardId == null) {
        response.sendRedirect("../main.jsp");
        return;
    }

    // DB 연결 정보
    String jdbcUrl = "jdbc:mysql://localhost:3309/portdb";
    String dbUser = "root";
    String dbPassword = "1234";
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String title = "", content = "", writer = "", createdAt = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

        // 게시글 정보 가져오기
        String sql = "SELECT title, content, writer, created_at FROM board WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(boardId));
        rs = pstmt.executeQuery();

        if (rs.next()) {
            title = rs.getString("title");
            content = rs.getString("content");
            writer = rs.getString("writer");
            createdAt = rs.getString("created_at");
        } else {
            response.sendRedirect("../main.jsp");  // 게시글이 없으면 메인으로 이동
            return;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= title %> - 상세보기</title>
</head>
<body>
    <h2>게시글 상세보기</h2>
    <h3><p><strong>제목:</strong> <%= title %></h3>
    <p><strong>작성자:</strong> <%= writer %></p>
    <p><strong>작성일:</strong> <%= createdAt %></p>
    <p><strong>내용:</strong></p>
    <p><%= content %></p>

	<!-- 수정 폼 추가 -->
	<%
		boolean isAdmin = isLoggedIn && userid.equals("admin");
    	boolean isWriter = isLoggedIn && userid.equals(writer);
	
		if (isWriter || isAdmin){
	%>
    <form action="Board_Update.jsp" method="post">
        <input type="hidden" name="id" value="<%= boardId %>">
        <div>
            <label for="title">제목:</label>
            <input type="text" id="title" name="title" value="<%= title %>" required>
        </div>
        <div>
            <label for="content">내용:</label>
            <textarea id="content" name="content" required><%= content %></textarea>
        </div>
        <button type="submit">수정</button>
    </form>
	<%
		} else {
	%>
		<p>※ 수정 권한이 없습니다.</p>
	<%
		}
	%>

    <!-- 삭제 버튼 (작성자 본인 또는 관리자만 가능) -->
    <%
        boolean isAdmin2 = isLoggedIn && userid.equals("admin");
        boolean isWriter2 = isLoggedIn && userid.equals(writer);

        if (isWriter2 || isAdmin2) {
    %>
        <form action="Board_Delete.jsp" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');">
            <input type="hidden" name="id" value="<%= boardId %>">
            <input type="submit" value="삭제">
        </form>
    <%
        } else {
    %>
        <p>※ 삭제 권한이 없습니다.</p>
    <%
        }
    %>

    <!-- 메인 페이지로 돌아가기 -->
    <a href="../main.jsp">메인 페이지로 돌아가기</a>
</body>
</html>
