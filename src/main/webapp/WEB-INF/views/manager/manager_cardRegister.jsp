
<!-- 
	일   시 : 2016.07.21
	작성자 : 배효열
	내   용 : 카드등록 뷰 페이지
	수   정 : 대분류 선택에 대한 소분류 자동변환
	일   정 : 명일(22), 이미지 파일 업로드까지 작업
 -->
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

//대분류 선택시, 소분류 자동변환
function big_cate_Change(){
	var big_num_value = $("#big_category > option:selected").val();
	$.ajax({
		url : "/manager/manager_cardRegister_small",
		type : "get",
		data : {"big_num" : $("#big_category > option:selected").val()},
		success : function(responseData){
			var count = Object.keys(responseData).length;
			var str = "";
			for(var i=0; i<count; i++){
				str += "<option value="+responseData[i].small_num+">"+responseData[i].small_name+"</option>";
			}
			
			$("#small_category").html(str);
		}
	});
}
</script>
</head>
<body>
<div class="container">
	<div class="span12">
		<h1>신규카드정보등록<small>Smart Choice</small></h1>
	</div>
	<br/>
	<hr style="border:#cfcfcf 1px solid"/>	
	<div class="container">	
		<div class="row">
			<div class="span6">
				<h3 class="text-success"><span class="badge badge-success">1</span>카드기본정보</h3>
			</div>
			<div class="span12" style="border: #cfcfcf solid 1px; padding: 10px;">
				<div class="row">
					<div class="span12">
						<h5 class="text-info"><span class="label label-info">STEP 1</span>카드 종류 선택</h5>
							<label class="radio inline" for="rtype1"><input type="radio" name="chk" id="rtype1" value="0" checked/>신용카드</label>
							<label class="radio inline" for="rtype2"><input type="radio" name="chk" id="rtype2" value="1"/>체크카드</label>						
						<h5 class="text-info"><span class="label label-info">STEP 2</span>카드사 선택</h5>
							<select>
								<c:forEach items="${companies }" var="CardDto">
									<option>${CardDto.comp_name }</option>
								</c:forEach>
							</select>
						<h5 class="text-info"><span class="label label-info">STEP 3</span>카드명 입력</h5>
							<input class="input-large" type="text" placeholder="Enter the CardName" required="required" id="getcardname"/>
						<h5 class="text-info"><span class="label label-info">STEP 4</span>연회비 입력</h5>
							<input class="input-large" type="number" min="0" max="100000" id="getcardfee" placeholder="Enter the Number" required="required" /><span class="help inline"></span>
						<h5 class="text-info"><span class="label label-info">STEP 5</span>전월실적 입력</h5>
								<input class="input-large" type="number" min="0" placeholder="Enter the Number" required="required" id="lastmon_rec"/>				
					</div>
				<br/>
				</div>				
			</div>
			<div class="span6">
				<h3 class="text-success"><span class="badge badge-success">2</span>카드혜택정보</h3>
			</div>
			<div class="span12" style="border: #cfcfcf solid 1px; padding: 10px;">
				<div class="row">
					<div class="span12">
						<h5 class="text-info"><span class="label label-info">STEP 1</span>대분류 선택</h5>
							<select id="big_category">
								<c:forEach items="${bigcategories }" var="bigC">
									<option value="${bigC.big_num }">${bigC.big_name }</option>
								</c:forEach>
							</select>
						<h5 class="text-info"><span class="label label-info">STEP 3</span>소분류 선택</h5>
							<select id="small_category"></select>
						<h5 class="text-info"><span class="label label-info">STEP 3</span>카드할인정보</h5>
						<h5 class="label inline">혜택정보입력</h5>
							<label class="radio inline" for="r_discount1"><input type="radio"  name="dis_chk" id="r_discount1" value="0"/><span>(%)</span></label>			
							<label class="radio inline" for="r_discount2"><input type="radio" name="dis_chk" id="r_discount2" value="1" checked/><span>(원)</span></label>
						<div class="controls">
							<input type="number" min="0" placeholder="할인정보를 입력하세요." id="dis_price" required="required" />
						</div>
						<h5 class="label inline">최소 결제금액 입력</h5>					
						<div class="controls">
							<input type="number" min="0" max="1000000" id="min_price" placeholder="최소결제금액을 입력하세요." required="required" />
						</div>
						<h5 class="label inline">최대 할인금액 입력</h5>					
						<div class="controls">
							<input type="number" min="0" id="max_price" placeholder="최대할인금액을 입력하세요." required="required" />
						</div>					
						<h5 class="label inline">기타정보입력</h5>
						<div class="controls">
							<input type="text" id="etc_data" placeholder="기타정보를 입력하세요." />
						</div>
					</div>
				</div>
			</div>
		</div>
	<br/><br/>
	</div>
</div>

<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>
