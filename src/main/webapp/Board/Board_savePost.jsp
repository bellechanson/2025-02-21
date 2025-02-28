<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%	
	// 한글 깨짐 방지
	request.setCharacterEncoding("UTF-8");
    // 세션 체크
    String userid = (String) session.getAttribute("userid");
    if (userid == null) {
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

        // DB 연결 체크
        if (conn == null) {
            throw new SQLException("DB 연결 실패! JDBC URL을 확인하세요.");
        }

        // 폼 데이터 가져오기
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String writer = request.getParameter("writer");

        // SQL 쿼리 실행: 게시글 저장
        String sql = "INSERT INTO board (title, content, writer) VALUES (?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, title);
        pstmt.setString(2, content);
        pstmt.setString(3, writer);
        int result = pstmt.executeUpdate();

        // 저장 성공 시, main.jsp로 리다이렉트
        if (result > 0) {
            response.sendRedirect("../main.jsp");  // 성공 후 main.jsp로 이동
        } else {
            out.println("게시글 저장에 실패했습니다.");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("오류 발생: " + e.getMessage());
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
