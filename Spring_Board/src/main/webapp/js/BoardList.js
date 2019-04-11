function checkAllDel(bool) {
	var chks = document.getElementsByName("chkVal");
//	alert(chks.length);
	for (var i = 0; i < chks.length; i++) {
		chks[i].checked = bool;
	}

}

function chkBox() {
//	alert("작동");
	var chks = document.getElementsByName("chkVal");
	var c = 0;
	for (var i = 0; i < chks.length; i++) {
		if (chks[i].checked) {
			c++;
		}
	}
	if (c>0) {
//		var doc = document.getElementById("frm");
//		var doc = document.form[0];
		var doc = document.frm;
		doc.action = "./multidel.do";
		return true;
	}else{
		swal("게시글 삭제 오류", "선택된 글이 없습니다.");
		return false;
	}
	
}

//////////////////////////// page 처리

function pageList() {
	var index = document.getElementById("index");
	var pageNum = document.getElementById("pageNum");
	var listNum = document.getElementById("listNum");
	
	index.value=0;
	pageNum.value=1;
	listNum.value=document.getElementById("list").value;
	
	pageAjax();
}


// 페이지 숫자 눌렀을 때
function pageIndex(pageNum) {
//	alert(pageNum);
	var index = document.getElementById("index");
	index.value = pageNum-1;
	
//	$("#index").val(pageNum-1);
	pageAjax();
}

//pageFirst(${row.pageList},${row.pageList})
function pageFirst(num, pageList) {
//	var index = 0;
//	var pageNum = 1;
	
	var pageNum = document.getElementById("pageNum");
	var index = document.getElementById("index");
	
	pageNum.value = 1;
	index.value = 0;
	
//	alert(pageNum.value);
//	alert(index.value);
	
	pageAjax();
}

//pagePre(${row.pageNum},${row.pageList})
function pagePre(num, pageList) {
	if (num-pageList>0) {
		num -= pageList;
		var pageNum = document.getElementById("pageNum");
		var index = document.getElementById("index");
		
		pageNum.value = num;
		index.value = num-1;
	}
	
	pageAjax();
}

//pageNext(${row.pageNum},${row.total},${row.listNum},${row.pageList})
function pageNext(num, total, listNum, pageList) {
	var index = Math.ceil(total/listNum); // 묵음
	var max = Math.ceil(index/pageList); // 글의 개수
	
	if (max*pageList > num+pageList) {
		num += pageList;
		
		var pageNum = document.getElementById("pageNum");
		var index = document.getElementById("index");
		
		pageNum.value = num;
		index.value = num-1;
	}
	
	pageAjax();
}

//pageLast(${row.pageNum},${row.total},${row.listNum},${row.pageList})
function pageLast(num, total, listNum, pageList){
	//  var max = Math.ceil(total/pageList); // 21/ 4
	//  var idx = Math.ceil(max/listNum); // 4/5 
	  
	  var idx = Math.ceil(total/listNum);
	  var max = Math.ceil(idx/pageList);
	  
	  while(max*pageList > num+pageList){
	     num += pageList;
	  }
	  
	  var pageNum = document.getElementById("pageNum");
	  var index = document.getElementById("index");
	  
	  pageNum.value= num;
	  index.value = idx-1;
	  
	//  pageNum.value = max - idx+1;
	//  index.value = max-1;
	  
	  pageAjax();
  
}



//////////////////////////////////////////////////////
///////////////////////////// 페이지 처리를 위한 공통 Ajax //
//////////////////////////////////////////////////////

var pageAjax = function() {
//	alert("Ajax 작동 예정");
//	var obj = document.getElementById("index").value;
	$.ajax({
		url : "./paging.do",
		type : "post",
		async: true,
		data : $("#frm").serialize(),		// "index="+obj   // JSON.stringify
		dataType : "json",
		success: function(msg) {
//			alert(msg.lists[0].seq);
//			alert(msg.row.total);
			$.each(msg,function(key, value){
				var htmlTable = "";
				var n = 0;
				n=$(".table tr:eq(0) th").length;
//				alert(n);
				
				if (key=="lists") { // table을 만들어 줌
					htmlTable += "<tr>"+
								"<th><input type='checkbox' onclick='checkAllDel(this.checked)'> </th>"+
								"<th>글 번호</th>"+
								"<th>제목</th>"+
								"<th>작성자</th>"+
								"<th>조회 수</th>";
					if(n == 7){
						htmlTable +="<th>삭제여부</th>";
					}			
								
					htmlTable +="<th>작성일</th></tr>";
					
					// 내용을 출력해 준다(lists:[{key,value},{},{}])
					$.each(value,function(key, fri){
						
						htmlTable += "<tr>" +
								"<td>" +
								"<input type='checkbox' name='chkVal' value='"+fri.seq+"'></td>" +
								"<td>"+fri.seq+"</td>" +
								"<td><div class='panel-heading'>" +
								"<a data-toggle='collapse' data-parent='#accordion' " +
								"href='#collapse"+fri.seq+"' " +
								"onclick='collapse(\""+fri.seq+"\")'>"+fri.title+"</a>" +
								"</div></td><td>"+fri.id+"</td><td>"+fri.readcount+"</td>";
						if(n==7){
							htmlTable +="<td>"+fri.delflag+"</td>";
						}		
						htmlTable +="<td>"+fri.regdate+"</td></tr>";
								
						htmlTable += "<tr>" +
								"<td colspan=\""+n+"\">" +
								"<div id='collapse"+fri.seq+"' " +
								"class='panel-collapse collapse' aria-expanded='false' style='hegiht:0px;'>" +
								"<div class='form-group'><label>내용</label><br>" +
								"<textarea row='7' class='form-control' readonly='readonly'>"+fri.content+"</textarea></div>" +
								"<div class='form-group'>";
						if(fri.id == fri.memid){
							htmlTable += "<input class='btn btn-primary' type='button' value='글 수정하기' onclick='modify(\""+fri.seq+"\")'>";
						}
						if (fri.id == fri.memid || n==7) {
							htmlTable += "<input class='btn btn-primary' type='button' value='글 삭제' onclick='del(\""+fri.seq+"\")'>";
						}
						if (n!=7) {
							htmlTable += "<input class='btn btn-primary' type='button' value='답글' onclick='reply(\""+fri.seq+"\")'>";
						}
						htmlTable += "</div></div></td></tr>";
						
						
					});
				}else{ // key=row는 paging을 만들어 줌
					
					htmlTable += "<li><a href='#' onclick='pageFirst("+value.pageList+","+value.pageList+")'>&laquo;</a></li>";
					htmlTable += "<li><a href='#' onclick='pagePre("+value.pageNum+","+value.pageList+")'>&lsaquo;</a></li>";
					
					for (var i = value.pageNum; i <= value.count; i++) {
						htmlTable += "<li><a href='#' onclick='pageIndex("+i+")'>"+i+"</a></li>";
					}
					htmlTable += "<li><a href='#' onclick='pageNext("+value.pageNum+","+value.total+","+value.listNum+","+value.pageList+")'>&rsaquo;</a></li>";
					htmlTable += "<li><a href='#' onclick='pageLast("+value.pageNum+","+value.total+","+value.listNum+","+value.pageList+")'>&raquo;</a></li>";
				}
				
				if (key=="lists") {
					$(".table > tbody").html(htmlTable);
				}else {
					$(".pagination").html(htmlTable);
				}
			});
			
		}
	});
}

// 수정, 삭제, 답글 관련 modal 기능
function modify(seq) {
//	alert(seq);
	ajaxModify(seq);
	$("#modify").modal();
}

var ajaxModify = function(seq) {
//	alert("ajax 메소드"+seq);
	$.ajax({
		url : "./modifyForm.do",
		type : "post",
		data : {"seq":seq},
		dataType : "json",
		success : function(obj) {
//			alert(obj.title);
			var htmlModal = "<input type='hidden' name='seq' value='"+obj.seq+"'>"+
			"<input type='hidden' name='id' value='"+obj.id+"'>"+
			"<div class='form-group'>"+
				"<label>글 번호</label>"+
				"<p class='form-control'>"+
					"<strong>"+obj.seq+"</strong>"+
				"</p>"+
			"</div>"+	
			"<div class='form-group'>"+
				"<label>조회 수</label>"+
				"<p class='form-control'>"+
					"<strong>"+obj.readcount+"</strong>"+
				"</p>"+
			"</div>"+	
			"<div class='form-group'>"+
				"<label>작성일</label>"+
				"<p class='form-control'>"+
					"<strong>"+obj.regdate+"</strong>"+
				"</p>"+
			"</div>"+		
			"<div class='form-group'>"+
				"<label>제목</label>"+
					"<input type='text' class='form-control' id='motitle' name='title' value='"+obj.title+"' required='required'>"+
			"</div>"+
			"<div class='form-group'>"+
				"<label>내용</label>"+
				"<textarea rows='7' class='form-control' id='mocontent' name='content' required='required'>"+obj.content+"</textarea>"+
			"</div>"+	
			"<div class='modal-footer'>"+
				"<input class='btn btn-success' type='button' value='글 수정' onclick='update()'>"+
				"<input class='btn btn-success' type='reset' value='초기화'>"+
			  	"<button type='button' class='btn btn-default' data-dismiss='modal'>닫기</button>"+
			"</div>";
			
			$("#frmModify").html(htmlModal);
		}
	});
}

function update() {
	var frm = document.getElementById("frmModify");
	frm.action = "./modify.do";
	var title = document.getElementById("motitle").value;
	var content = $("#mocontent").val();
	
//	alert(title+"/"+content);
	if (title=="" || content=="") {
		swal("글 수정 오류", "제목 혹은 내용을 입력 해주세요.");
	}else{
		frm.submit();
	}

}

// 삭제
function del(seq) {
	location.href="./del.do?seq="+seq;
}

// 답글 관련 modal 기능
function reply(seq) {
//	alert(seq);
	ajaxReply(seq);
	$("#reply").modal();
}
var ajaxReply = function(seq) {
	$.ajax({
		url : "./replyForm.do",
		type : "post",
		data : {"seq":seq},
		async: true,
		dataType : "json",
		success : function(obj) {
			var replyHTML = "<input type='hidden' name='seq' value='"+obj.seq+"'>"+
		"<div class='form-group'>"+
			"<label>답글 할 글 번호</label><br>"+
			"<p class='form-control'>"+obj.seq+"</p>"+
		"</div>"+
		"<div class='form-group'>"+
			"<label>답글 할 글 조회 수</label><br>"+
			"<p class='form-control'>"+obj.readcount+"</p>"+
		"</div>"+
		"<div class='form-group'>"+
			"<label>답글 할 글 작성일</label><br>"+
			"<p class='form-control'>"+obj.regdate+"</p>"+
		"</div>"+
		"<div class='form-group'>"+
			"<label>답글 할 글 작성자</label><br>"+
			"<p class='form-control'>"+obj.memid+"</p>"+
		"</div>"+
		"<div class='form-group'>"+
			"<label id='titl'>제목(원본)</label><br>"+
			"<input type='text' class='form-control' id='title' name='title' value='"+obj.title+"' required='required' onclick='chk()'>"+
		"</div>"+
		"<div class='form-group'>"+
			"<label id='con'>내용(원본)</label>"+
			"<input type='hidden' id='hiddenContent' value='"+obj.content+"'>"+
			"<textarea id='txtArea' rows='7' class='form-control' onclick='chk()' name='content'>"+obj.content+"</textarea>"+
		"</div>"+
		"<div class='modal-footer'>"+
			"<input type='button' class='btn btn-warning' value='답글 작성' onclick='replied()'>"+
			"<input type='reset' class='btn btn-warning' value='초기화' onclick='titleReset()'>"+
			"<button type='button' class='btn btn-default' data-dismiss='modal'>닫기</button>"+
		"</div>";
			
		$("#frmReply").html(replyHTML);	
		}
	});
}

function replied() {
	var frm = document.getElementById("frmReply");
	frm.action = "./reply.do";
	var title = document.getElementById("title").value;
	var txtArea = document.getElementById("txtArea").value;
//	alert(title+":"+txtArea);
	if (title=="" || txtArea=="") {
		swal("답글 작성 오류","제목 혹은 내용을 작성해 주세요.");
	}else{
		var titl = document.getElementById("titl").innerHTML;
		if (titl == "제목") {
			frm.submit();
		}else{
			swal("답글 작성 오류","답글을 먼저 작성해 주세요.");
		}
	}
}

function chk() {
//	alert("작동");
	var titl = document.getElementById("titl");
	var title = document.getElementById("title");
	var con = document.getElementById("con");
	var txtArea = document.getElementById("txtArea");
	var hiddenContent = document.getElementById("hiddenContent");
	
	if (hiddenContent.value == txtArea.value) {
		con.innerHTML = "내용";
		titl.innerHTML = "제목";
		txtArea.value = "";
		title.value="";
	}
}

function titleReset() {
	document.getElementById("titl").innerHTML = "제목(원본)";
	document.getElementById("con").innerHTML= "내용(원본)";
}