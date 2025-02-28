<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // 사용자 정보를 입력받은 후 처리
    String errorMessage = "";
    
    // 폼 데이터가 POST로 전송되면 처리 시작
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String userid = request.getParameter("userid");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String email = request.getParameter("email");

        // 데이터 유효성 체크
        if (userid != null && password != null && name != null && email != null) {
            // DB 연결 정보
            String jdbcUrl = "jdbc:mysql://localhost:3309/portdb";
            String dbUser = "root";
            String dbPassword = "1234";
            
            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                // DB 연결
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

                // 사용자 아이디 중복 체크
                String checkSql = "SELECT COUNT(*) FROM users WHERE userid = ?";
                pstmt = conn.prepareStatement(checkSql);
                pstmt.setString(1, userid);
                ResultSet rs = pstmt.executeQuery();
                rs.next();
                if (rs.getInt(1) > 0) {
                    errorMessage = "아이디가 이미 존재합니다.";
                } else {
                    // 비밀번호 암호화 (예: 간단한 MD5 암호화 사용)
                    String encryptedPassword = password; // 실제로는 암호화 로직을 사용해야 함.

                    // 데이터 삽입
                    String insertSql = "INSERT INTO users (userid, password, name, email) VALUES (?, ?, ?, ?)";
                    pstmt = conn.prepareStatement(insertSql);
                    pstmt.setString(1, userid);
                    pstmt.setString(2, encryptedPassword);
                    pstmt.setString(3, name);
                    pstmt.setString(4, email);
                    pstmt.executeUpdate();
                    
                    response.sendRedirect("Login/login.jsp"); // 회원가입 후 로그인 페이지로 리다이렉트
                    return;
                }
            } catch (Exception e) {
                e.printStackTrace();
                errorMessage = "회원가입 중 오류가 발생했습니다.";
            } finally {
                if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
                if (conn != null) try { conn.close(); } catch (Exception e) {}
            }
        } else {
            errorMessage = "모든 필드를 채워주세요.";
        }
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
</head>
<body>
    <h2>회원가입</h2>
    
    <!-- 에러 메시지 출력 -->
    <p style="color: red;"><%= errorMessage %></p>

    <!-- 회원가입 폼 -->
    <form action="signup.jsp" method="post">
        <div>
            <label for="userid">아이디:</label>
            <input type="text" id="userid" name="userid" required>
        </div>
        <div>
            <label for="password">비밀번호:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div>
            <label for="name">이름:</label>
            <input type="text" id="name" name="name" required>
        </div>
        <div>
            <label for="email">이메일:</label>
            <input type="email" id="email" name="email" required>
        </div>
        <button type="submit">회원가입</button>
    </form>

    <br>
    <a href="Login/login.jsp">로그인 페이지로 가기</a>
</body>
</html>
