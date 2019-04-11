<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <% request.setCharacterEncoding("UTF-8"); %>
    <% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에러 페이지</title>
</head>
	<%
		String errMsg = (String)request.getAttribute("errMsg");
		String url = (String)request.getAttribute("url");
	%>
<body>
	<h1><%=errMsg%></h1>
	<a href="<%=url%>">돌아가기</a>
</body>
</html>