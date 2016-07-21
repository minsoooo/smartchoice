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
	//선택한 big_category의 데이터 저장
	
	console.log(big_num_value);
	alert(big_num_value);
	$.get("/manager/manager_cardRegister", {big_num: big_num_value},
		function(data){
			console.log(data);
			var str ="";
			$("#small_category").children().remove();
			//console.log(data.length);
			//alert(data.length);
			if(data.length != null){				
				str = "<c:forEach items='${smallcategories }' var='smallC' ><option value='${smallC.small_num }'>${smallC.small_name }</option></c:forEach>";

			}
			else{
				str = "<option selected disabled>카테고리를 선택하세요.</option><option disabled>------------------------------------</option>";
			}
			console.log(str);
			//alert(str);
			$("#small_category").html(str);
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
