<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String boardId = request.getParameter("id");

    if (boardId == null) {
        response.sendRedirect("main.jsp");
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

        // 게시글 삭제 쿼리
        String deleteSql = "DELETE FROM board WHERE id = ?";
        pstmt = conn.prepareStatement(deleteSql);
        pstmt.setInt(1, Integer.parseInt(boardId));
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            // 삭제 성공 후 메인 페이지로 리다이렉트
            response.sendRedirect("../main.jsp");
        } else {
            // 삭제 실패 시 에러 메시지 출력
            out.println("게시글 삭제 실패!");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
