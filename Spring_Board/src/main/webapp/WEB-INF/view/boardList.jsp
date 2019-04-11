<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/BoardList.css">
<link rel="stylesheet" href="./jqgrid/css/ui.jqgrid.css">
<script type="text/javascript" src="./js/BoardList.js"></script>
<script type="text/javascript" src="./jqgrid/js/jquery.jqGrid.min.js"></script>
</head>
<body>
<%@include file="/WEB-INF/view/boardTopMenu.jsp" %>

<div id="container">
	<!-- 게시판 폼 -->
	<div id="select">
		<span>
			<select class="btn btn-primary" id="list" name="list" onchange="pageList()">
				<option value="5">5</option>
				<option value="10">10</option>
				<option value="15">15</option>
				<option value="20">20</option>
			</select>
		</span>
	</div>
	
	<form action="#" method="post" name="frm" id="frm" onsubmit="return chkBox()">
		<div>
			<input class="btn btn-danger" type="submit" value="다중삭제">
		</div>
		<div class="panel-group" id="accordion">
			<table class="table table-bordered">
				<tr>
					<th><input type="checkbox" onclick="checkAllDel(this.checked)"> </th>
					<th>글 번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>조회 수</th>
					<c:if test="${fn:trim(mem.auth) eq 'A'}">
						<th>삭제여부</th>
					</c:if>
					<th>작성일</th>
				</tr>
				
				<jsp:useBean id="format" class="com.happy.prj.beans.InputList" scope="page"/>
				<jsp:setProperty property="lists" name="format" value="${lists}"/>
				<jsp:setProperty property="mem" name="format" value="${mem}"/>
				<jsp:getProperty property="listformat" name="format"/>
				
			</table>
		</div>
	
	<!-- 현재 페이지, 인덱스, 출력 개수 -->
	<input type="hidden" id ="index" name="index" value="${row.index}">
	<input type="hidden" id ="pageNum" name="pageNum" value="${row.pageNum}">
	<input type="hidden" id ="listNum" name="listNum" value="${row.listNum}">
				
	<div class="center">
		<ul class="pagination">
			<li><a href="#" onclick="pageFirst(${row.pageList},${row.pageList})">&laquo;</a></li>
			<li><a href="#" onclick="pagePre(${row.pageNum},${row.pageList})">&lsaquo;</a></li>
	
			<c:forEach var="i" begin="${row.pageNum}" end="${row.count}" step="1">
				<li><a href="#" onclick="pageIndex(${i})">${i}</a></li>
			</c:forEach>
			
			<li><a href="#" onclick="pageNext(${row.pageNum},${row.total},${row.listNum},${row.pageList})">&rsaquo;</a></li>
			<li><a href="#" onclick="pageLast(${row.pageNum},${row.total},${row.listNum},${row.pageList})">&raquo;</a></li>
		</ul>
	</div>
	
	</form>
	
	<!-- 수정폼 -->
	<div id="modify" class="modal fade" role="dialog">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">게시글 수정</h4>
	      </div>
	      <div class="modal-body">
	        <form action="#" role="form" method="post" id="frmModify"></form>
	      </div>
	    </div>
	  </div>
	</div>

	<!-- 수정 modal -->
	<div>
		
	</div>
	
	<!-- 답글 쓰기 폼 -->	
	<div id="reply" class="modal fade" role="dialog">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">답글쓰기</h4>
	      </div>
	      <div class="modal-body">
	        <form role="form" action="#" method="post" id="frmReply"></form>
	      </div>
	    </div>
	  </div>
	</div>
	
	<div>
		
	</div>
	
</div>

<script type="text/javascript">
	$(document).ready(function() {
		var listNum=$("#listNum").val();
		$("#list option").each(function(){
			 if(listNum == $(this).val()){
				 $(this).prop("selected", true);
			 }else{
				 $(this).prop("selected", false);
			 }
		});
	});
		
	
</script>
</body>
</html>