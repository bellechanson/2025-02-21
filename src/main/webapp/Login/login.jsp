<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>노래 사이트 - 로그인</title>
</head>
<body>
    <h2>로그인</h2>
    <form action="loginProcess.jsp" method="post">
        <div>
            <label for="userid">아이디:</label>
            <input type="text" id="userid" name="userid" required>
        </div>
        <div>
            <label for="password">비밀번호:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <button type="submit">로그인</button>
    </form>
</body>
</html>
