<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <% request.setCharacterEncoding("UTF-8"); %>
    <% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메일 보내기 화면</title>
</head>
<body>
	<%@include file="/WEB-INF/view/boardTopMenu.jsp" %>
	<div id="container">
		<form action="./mailSending.do" method="post">
			<div align="center">
				<input type="text" name="toMail" size="120px" width="100%" placeholder="상대방 메일 주소 입력">
			</div>
			<div align="center">
				<input type="text" name="title" size="120px" width="100%" placeholder="제목을 입력">
			</div>
			<p>
			<div align="center">
				<textarea name="content" rows="12" cols="120" width="100%" placeholder="메일 내용"></textarea>
			</div>
			<div align="center">
				<input type="submit" value="메일 보내기">
			</div>
		</form>
	</div>
</body>
</html>