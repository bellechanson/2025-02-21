<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>노래 사이트123</title>
    <style>
    	@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap');
    	
		body {
	       font-family: 'Noto Sans KR', sans-serif;
	       background: linear-gradient(135deg, #79F1A4, #0E5CAD);
	       height: 100vh;
	       display: flex;
	       justify-content: center;
	       align-items: center;
	       margin: 0;
	     }
       	.login-container {
       		width: 300px;
			padding: 25px;
			background: white;
			border-radius: 10px; 
			box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); 
			text-align: center;
		}
		h2 {
    		margin-bottom: 20px;
    		color: #333;
		}
        .form-group {
    		margin-bottom: 15px;
   			text-align: left;
		}
        input[type="text"], input[type="password"] {
    		width: 93%;
    		padding: 10px;
    		margin-top: 5px;
   			border: 1px solid #ccc;
    		border-radius: 5px;
    		font-size: 14px;
    	}
        button {
		    width: 100%;
		    padding: 12px;
		    background: #007bff;
		    color: white;
		    border: none;
		    border-radius: 5px;
		    font-size: 16px;
		    cursor: pointer;
		    transition: 0.3s;
		}
		button:hover {
    		background: #0056b3;
		}
    </style>
</head>
<body>
    <div class="login-container">
        <h2>로그인</h2>
        <form action="loginProcess.jsp" method="post">
            <div class="form-group">
                <label for="userid">아이디:</label>
                <input type="text" id="userid" name="userid" required>
            </div>
            <div class="form-group">
                <label for="password">비밀번호:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit">로그인</button>
        </form>
    </div>
</body>
</html> 