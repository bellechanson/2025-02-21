<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // 로그인 여부 확인
    String userid = (String) session.getAttribute("userid");
    boolean isLoggedIn = (userid != null);

    if (!isLoggedIn) {
        response.sendRedirect("../login.jsp");
        return;
    }

    // 수정된 제목과 내용 가져오기
    String boardId = request.getParameter("id");
    String title = request.getParameter("title");
    String content = request.getParameter("content");

    if (boardId == null || title == null || content == null) {
        response.sendRedirect("../main.jsp");
        return;
    }

    // DB 연결 정보
    String jdbcUrl = "jdbc:mysql://localhost:3309/portdb";
    String dbUser = "root";
    String dbPassword = "1234";
    
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

        // 게시글 수정 SQL
        String sql = "UPDATE board SET title = ?, content = ? WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, title);
        pstmt.setString(2, content);
        pstmt.setInt(3, Integer.parseInt(boardId));

        int result = pstmt.executeUpdate();

        if (result > 0) {
            // 수정 성공 시 메인 페이지로 리다이렉트
            response.sendRedirect("Board_View.jsp?id=" + boardId);
        } else {
            // 수정 실패 시 오류 메시지
            out.println("<script>alert('수정 실패'); history.back();</script>");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('오류 발생'); history.back();</script>");
    }
%>
