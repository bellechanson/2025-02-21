<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>새 글 작성</title>
</head>
<body>
    <h1>새 글 작성</h1>

    <form action="Board_savePost.jsp" method="post">
        <div>
            <label for="title">제목</label>
            <input type="text" id="title" name="title" required placeholder="제목을 입력하세요">
        </div>
        <div>
            <label for="content">내용</label>
            <textarea id="content" name="content" required placeholder="내용을 입력하세요"></textarea>
        </div>

        <div>
            <label for="writer">작성자</label>
            <input type="text" id="writer" name="writer" value="<%= session.getAttribute("userid") %>" readonly>
        </div>

        <button type="submit">저장</button>
    </form>
</body>
</html>
