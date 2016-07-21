<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<title>카드등록</title>
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css" />
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script>
$(function(){
	$("#big_category").bind("change", big_cate_Change);
	big_cate_Change();
});
function big_cate_Change(){
	var big_num_value = $("#big_category > option:selected").val();
	//$("#small_category").children().remove();
	
	console.log(big_num_value);
	alert(big_num_value);
	
	$.ajax({
		url : "/manager/manager_cardRegister",
		type : "get",
		data : {"big_num" : $("#big_category > option:selected").val()},
		success : function(responseData){
			var data = JSON.parse(responseData);
			var str = "";
			if(data){
				str = "<c:forEach items='${smallcategories }' var='smallC' ><option value='${smallC.small_num }'>${smallC.small_name }</option></c:forEach>";
			}else{
				str = "<option selected disabled>카테고리를 선택하세요.</option><option disabled>------------------------------------</option>";
			}
			$("#small_category").html(str);
		}
	});
	
	/*
	$.get("/manager/manager_cardRegister", {"big_num": big_num_value}).done(
		function(data){
			console.log(data);
			
			$("#small_category").children().remove();
			var str ="";
			
			if(data.length != null){				
				str = "<c:forEach items='${smallcategories }' var='smallC' ><option value='${smallC.small_num }'>${smallC.small_name }</option></c:forEach>";

			}
			else{
				str = "<option selected disabled>카테고리를 선택하세요.</option><option disabled>------------------------------------</option>";
			}
			console.log(str);
			//alert(str);
			$("#small_category").html(str);
	*/
			/*
			if(data.length>0){
				for(var i=0; i<data.length; i++){
					str+=
					"<option value=' + '"${smallC.small_num }"'+">${smallC.small_name }</option>";
				}
			}else{
				str+="<option selected disabled>카테고리를 선택하세요.</option><option disabled>------------------------------------</option>";
			}
			$("#small_category").html(str);
			*/
		}

	);
}
</script>
</head>
<body>
<h1>카드등록</h1>
<hr/>
<h3>1단계 카드 기본정보</h3>
<select>
	<c:forEach items="${companies }" var="CardDto">
		<option>${CardDto.comp_name }</option>
	</c:forEach>
</select><br/><hr/>

<h3>2단계 카드 혜택정보</h3><br/>
<h5>대분류</h5>
<select id="big_category">
	<c:forEach items="${bigcategories }" var="bigC">
		<option value="${bigC.big_num }">${bigC.big_name }</option>
	</c:forEach>
</select>
<h5>소분류</h5>
<select id="small_category"></select>

<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>
