<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <% request.setCharacterEncoding("UTF-8"); %>
    <% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입 화면</title>
<link rel="stylesheet" type="text/css" href="./css/sweetalert.css">
<link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="./css/bootstrap-theme.min.css">
<link rel="stylesheet" type="text/css" href="./css/SignUp.css">

<script type="text/javascript" src="./js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="./js/bootstrap.min.js"></script>
<script type="text/javascript" src="./js/sweetalert.min.js"></script>
</head>
<script type="text/javascript">
	function check() {
		// pw 확인, id 중복
		var pw = document.getElementById("pw").value;
		var passOK = document.getElementById("passOK").value;
// 		alert(pw+":"+passOK);

		var frm = document.forms[0]; // document.frm // document.getElementById("frm")
		
		var chk = document.getElementById("chkVal").value;
// 		alert(chk);		
		
		if (pw!=passOK) {
			swal("회원가입 실패:","비밀번호를 확인해 주세요");
			return false;
		}else if(chk == "0"){
			swal("회원가입 실패:","아이디 중복 체크를 해주세요");
			return false;
		}else{
			return true;
		}
	}
	
	// id중복+유효값 ajax
	$(document).ready(function() {
		$("#id").keyup(function() {
			var inputLength = $(this).val().length;
// 			alert(inputLength);
			var id=$(this).val();
			
			// 공백 유효 값 검사
			if (id.indexOf(" ") != -1) {
// 				alert("공백 있음");
				$("#result").css("color", "red");
				$("#result").html("공백이 포함된 아이디는 사용이 불가 합니다.");
				$("#chkVal").val("0"); // document.getElementById("chkVal").value="0";
			}else if(inputLength > 5){
// 				alert("ajax 작동");
				jQuery.ajax({
					url : "./idCheck.do",
					type : "post",
					data : "id="+$(this).val(),
					async : true,
					success : function(msg) {
// 						alert(msg);	
						$("#result").html(msg);
						var temp = msg;
						temp = temp.substring(0, temp.indexOf("디")+1);
						if (temp == "사용가능한 아이디") {
							$("#chkVal").val(1);
							$("#result").css("color", "blue");
						}else{
							$("#chkVal").val(0);
							$("#result").css("color", "red");
						}
					}
				});
			}else{
				$("#result").css("color", "red");
				$("#result").html("6자리 이상만 사용 가능 합니다.");
				$("#chkVal").val("0"); // document.getElementById("chkVal").value="0";
			}
		});
	});
	
</script>
<body>
	<div id="container">
		<div id="title">
			<img id="TitleImage" src="./image/signuptitle.png">
		</div>

	
	<input type="hidden" value="0" id="chkVal">
	
	<form action="./signUp.do" method="post" id="frm" onsubmit="return check()">
		<div id="info">
			<div id="LeftInfo">정보입력</div>
			
			<div id="CenterInfo">
				<input type="text" id="name" name="name" placeholder="이름" required="required">
				<br>
				
				<input type="text" id="id" name="id" placeholder="아이디" required="required">
				<br>
				<span id="result"></span>
				<br>
				
				<input type="text" id="pw" name="pw" placeholder="비밀번호" required="required">
				<br>
				<input type="text" id="passOK" placeholder="비밀번호 확인" required="required">
				
			</div>

			<div id="RightInfo">
			
			</div>
		</div>
		<div id="line"></div>
		
		<div id="bottom">
			<br>
			*만 14세 미만의 법정대리인 동의 후 회원서비스를 이용 가능 합니다.
			<br>
			*선택 약관에 동의하지 않아도 회원가입은 가능합니다.
			<br>
			<strong id="bottomStrong">
				약관과 개인정보 수집 및 이용을 확인하였으며 이에 동의 합니까?
			</strong>
			<br>
			
			<div id="button">
				<input class="btn btn-success" type="submit" value="동의하고 회원가입">
				<input class="btn btn-sm btn-primary" type="button" value="돌아가기" onclick="javascript:history.back(-1)">
<!-- 				onclick="javascript:location.href='./test.do'" -->
			</div>
			
			
		</div>
	</form>
	</div>
</body>
</html>