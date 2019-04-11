<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <% request.setCharacterEncoding("UTF-8"); %>
    <% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>
		<a href="./loginForm.do">로그인 폼 이동</a>
	</h1>
	
	<a href="./signUp.do?id=happy&name=happy&pw=happy">회원가입</a>
	<a href="./idCheck.do?id=happy">아이디 확인</a>
	<a href="./login.do?id=TEST001&pw=TEST001">로그인</a>
	<a href="./memberList.do">회원 리스트</a>
	
	<hr>
	
	<a href="./writeBoard.do?id=gold99&title=안녕하세요&content=인사합니다">root글 작성하기</a>
	<a href="./reply.do?seq=21&id=TEST001&title=답글1&content=답글입니다">답글달기</a>
	<a href="./getOneBoard.do?seq=21">상세글 조회</a>
	<a href="./readcountBoard.do?seq=21">조회수 증가</a>
	<a href="./modifyBoard.do?seq=21&title=군대&content=정현이 군대갈 예정">수정</a>
	<a href="./delflagBoard.do?seq=22">delflag</a>
	<a href="./deleteBoardSel.do?seq=20">삭제선택</a>
	<a href="./userBoardListTotal.do">사용자가 볼 수 있는 글 개수</a>
	<a href="./adminBoardListTotal.do">관리자가 볼 수 있는 글 개수</a>
	<a href="./userBoardListRow.do">사용자 글 개수</a>
	<a href="./adminBoardListRow.do">관리자 글 개수</a>
	<a href="./jqgrid.do">jqgrid Test</a>
</body>
</html>