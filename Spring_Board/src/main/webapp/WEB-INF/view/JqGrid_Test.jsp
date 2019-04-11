<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <% request.setCharacterEncoding("UTF-8"); %>
    <% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JqGrid Test</title>
<link rel="stylesheet" href="./jqgrid/css/ui.jqgrid.css">
<script type="text/javascript" src="./jqgrid/js/jquery.jqGrid.min.js"></script>
</head>
<script type="text/javascript">
$(document).ready(function(id, array){
    $("#"+id).jqGrid({
           datatype: "local",
           height: 250, 
           width : 630,
           colNames:['일시','속도', 'RPM', '브레이크','상태'],
           colModel:[
               {name:'fOcurDtmc', align:'right'},
               {name:'spd', align:'right'},
               {name:'rpm', align:'right'},
               {name:'brkYn', align:'right'},
               {name:'status', align:'right'}    
           ],
           caption: "DTG 데이터"
     });

     for(var I in array){
          $("#"+id).jqGrid('addRowData',i+1,array[i]);
     }
});

makeTable('table1', dataArray);


</script>
<body>
	<table id="table1">
		<input type="button" value="클릭" onclick="makeTable('table1', dataArray)">
	</table>
</body>
</html>