<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    int songId = Integer.parseInt(request.getParameter("id")); // URL에서 id 가져오기

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String title = "", artist = "", genre = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3309/portdb", "root", "1234");

        String sql = "SELECT title, artist, genre FROM songs WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, songId);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            title = rs.getString("title");
            artist = rs.getString("artist");
            genre = rs.getString("genre");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= title %> - 상세 정보</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 400px;
            width: 90%;
        }
        h2 {
            color: #333;
        }
        p {
            font-size: 16px;
            color: #555;
        }
        .back-btn {
            display: inline-block;
            margin-top: 15px;
            padding: 10px 15px;
            background: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: 0.3s;
        }
        .back-btn:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2><%= title %></h2>
        <p><strong>아티스트:</strong> <%= artist %></p>
        <p><strong>장르:</strong> <%= genre %></p>
        <a href="main.jsp" class="back-btn">뒤로 가기</a>
    </div>
</body>
</html>
