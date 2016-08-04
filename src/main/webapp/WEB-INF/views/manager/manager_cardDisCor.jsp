<!-- 
	일   시 : 2016.07.31
	작성자 : 배효열
	내   용 : 카드할인정보 수정 뷰 페이지
	수   정 : 
	일   정 : 
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@page import="java.util.ArrayList"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<title>카드할인정보수정</title>
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css" />
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script src="/resources/plugins/jQuery/jquery.form.min.js"></script>
<script src="/resources/plugins/js/array.js"></script>
<script>
$(function(){
	$("#big_category").bind("change", big_cate_Change);
	big_cate_Change();
	
	//카드할인정보 : 2단계 적용 버튼
	$("#card_reg_step2").bind("click", card_reg_step2_Click);
	$("#card_reg_step3").bind("click", card_reg_step3_Click);
	$("#card_clear_step2").bind("click", card_clear_step2_Click);
	
	//카드할인정보 : 할인타입 선택(per/won)
	$("#r_discount1").bind("click", r_discount1_Click);
	$("#r_discount2").bind("click", r_discount2_Click);
	r_discount2_Click();
	
});
var list = new Array();
var dc_value="";
var dc_min="";
var dc_max="";
var dc_etc="";
var dc_cardcode="";
var dc_smallnum="";
var dc_classify="";
var dc_num="";
var dc_cornum="";
var card_code="";
var dc_corcardcode ="";
var card_small_name="";
var dis_type="";


var card_option_text = "";//선택한 데이터가 여러 개일 경우, 모든 데이터를 담도록 변수선언 
var option_small_val = new ArrayList();//선택한 소분류 밸류
var option_type = new ArrayList();//입력한 카드할인 퍼센트/원
var option_discount = new ArrayList();//입력한 카드할인밸류
var option_min = new ArrayList();//입력한 최소결제금액
var option_max = new ArrayList();//입력한 최대할인한도
var option_etc = new ArrayList();//기타사항

function card_reg_step2_Click() {
 	
	dc_num = dc_cornum;
	dc_min = $("#min_paid").val();
	dc_max = $("#max_discount").val();
	dc_etc = $("#etc_data").val();
	if(dc_corcardcode == ""){
		dc_cardcode = $("#cardcode").val();
	}else{	
		dc_cardcode = dc_corcardcode;
	}
	dc_smallnum = $("select[name='select_small'] > option:selected").val();
	card_small_name = $("#card_small_name_" + dc_smallnum).text();

	//카드할인정보 : 할인타입-DB에 저장될 데이터값
	dc_classify = $('input[name="dis_chk"]:checked').val();
	//카드할인정보 : 할인타입-사용자에게 출력될 데이터값
	if (dc_classify == 0) {
		dc_value = $("#discount_per").val();
		dis_type = "percent";
	} else {
		dc_value = $("#discount_won").val();
		dis_type = "won";
	}		

	
	//카드할인정보 : 소분류 중복 유효성 검사
	if (option_small_val.size() > 0) {
		for (var i = 0; i < option_small_val.size(); i++) {
			console.log("card_small_num " + dc_smallnum
					+ " option_small_val.get(" + i + "): "
					+ option_small_val.get(i));
			if (dc_smallnum == option_small_val.get(i)) {
				alert("중복된 데이터가 있습니다.");
				return false;
			}
		}
	}
	//할인정보 : 소분류 데이터값 중복 확인을 위한 리스트에 저장
	option_small_val.add(dc_smallnum);
	
	card_option_text = "<tr class="+'"warning"'+"><td>할인대상 : "
			+ card_small_name + "</td><td>할인타입 : " + dis_type + "</td><td>할인정보 : " + dc_value
			+ "</td></tr>"+"<tr class="+'"warning"'+"><td>최소결제 : " + dc_min + "</td>"
			+ "<td>할인한도 : " + dc_max + "</td>" + "<td>기타사항 : "
			+ dc_etc + "</td></tr>";

	$("#table_step2").html(card_option_text);

	var CardDiscountDto = new Object;
	CardDiscountDto.dc_num=dc_num;
	CardDiscountDto.dc_smallnum=dc_smallnum;
	CardDiscountDto.dc_classify=dc_classify;
	CardDiscountDto.dc_value=dc_value;
	CardDiscountDto.dc_min=dc_min;
	CardDiscountDto.dc_max=dc_max;
	CardDiscountDto.dc_etc=dc_etc;
	CardDiscountDto.dc_cardcode=dc_cardcode;

	list.push(CardDiscountDto);
	
}
function card_reg_step3_Click() {
 	
	dc_num = dc_cornum;
	dc_min = $("#min_paid").val();
	dc_max = $("#max_discount").val();
	dc_etc = $("#etc_data").val();
	if(dc_corcardcode == ""){
		dc_cardcode = $("#cardcode").val();
	}else{	
		dc_cardcode = dc_corcardcode;
	}
	dc_smallnum = $("select[name='select_small'] > option:selected").val();
	card_small_name = $("#card_small_name_" + dc_smallnum).text();

	//카드할인정보 : 할인타입-DB에 저장될 데이터값
	dc_classify = $('input[name="dis_chk"]:checked').val();
	//카드할인정보 : 할인타입-사용자에게 출력될 데이터값
	if (dc_classify == 0) {
		dc_value = $("#discount_per").val();
		dis_type = "percent";
	} else {
		dc_value = $("#discount_won").val();
		dis_type = "won";
	}		

	
	//카드할인정보 : 소분류 중복 유효성 검사
	if (option_small_val.size() > 0) {
		for (var i = 0; i < option_small_val.size(); i++) {
			console.log("card_small_num " + dc_smallnum
					+ " option_small_val.get(" + i + "): "
					+ option_small_val.get(i));
			if (dc_smallnum == option_small_val.get(i)) {
				alert("중복된 데이터가 있습니다.");
				return false;
			}
		}
	}
	//할인정보 : 소분류 데이터값 중복 확인을 위한 리스트에 저장
	option_small_val.add(dc_smallnum);
	
	card_option_text += "<tr class="+'"warning"'+"><td>할인대상 : "
			+ card_small_name + "</td><td>할인타입 : " + dis_type + "</td><td>할인정보 : " + dc_value
			+ "</td></tr>"+"<tr class="+'"warning"'+"><td>최소결제 : " + dc_min + "</td>"
			+ "<td>할인한도 : " + dc_max + "</td>" + "<td>기타사항 : "
			+ dc_etc + "</td></tr>";

	$("#table_step2").html(card_option_text);

	var CardDiscountDto = new Object;
	CardDiscountDto.dc_num=dc_num;
	CardDiscountDto.dc_smallnum=dc_smallnum;
	CardDiscountDto.dc_classify=dc_classify;
	CardDiscountDto.dc_value=dc_value;
	CardDiscountDto.dc_min=dc_min;
	CardDiscountDto.dc_max=dc_max;
	CardDiscountDto.dc_etc=dc_etc;
	CardDiscountDto.dc_cardcode=dc_cardcode;

	list.push(CardDiscountDto);
	
}
//2단계 할인정보 초기화
function card_clear_step2_Click() {
	$('#table_step2 td').text("");
	card_option_text = "";

	var set_bigCtg = $("select[name='select_big'] option").eq(0).val();
	$("select[name='select_big']").val(set_bigCtg);
	big_cate_Change();

	var discount_type = $('input[name="dis_chk"]:checked').val();
	if (discount_type == 0) {
		$("#discount_per").val("");
	} else {
		$("#discount_won").val("");
	}
	$("input[name='dis_chk']").eq(1).prop("checked", true);//할인타입 초기화
	r_discount2_Click();
	$("#min_paid").val("");
	$("#max_discount").val("");
	$("#etc_data").val("");

	option_small_val = "";
	option_small_val = new ArrayList();//초기화시 새롭게 데이터를 받을 수 있도록 인스턴스생성
	option_type = new ArrayList();//입력한 카드할인 퍼센트/원
	option_discount = new ArrayList();//입력한 카드할인밸류
	option_min = new ArrayList();//입력한 최소결제금액
	option_max = new ArrayList();//입력한 최대할인한도
	option_etc = new ArrayList();//기타사항
	list = null;//초기화시 리스트 초기화
	list = new Array();
}
function r_discount1_Click() {
	var discount_type = $('input[name="dis_chk"]:checked').val();
	var discount_type_str = "";
	if (discount_type == "0") {
		discount_type_str = "<input type=" + '"number"' + "min=" + '"0"'
				+ "max=" + '"100"' + "placeholder=" + '"할인정보(%)를 입력하세요."'
				+ "id=" + '"discount_per"' + "required=" + '"required"'
				+ "/>"
	}
	$("#discount_type").html(discount_type_str);
}
function r_discount2_Click() {
	var discount_type = $('input[name="dis_chk"]:checked').val();
	var discount_type_str = "";
	if (discount_type == "1") {
		discount_type_str = "<input type=" + '"number"' + "min=" + '"0"'
				+ "placeholder=" + '"할인정보(원)를 입력하세요."' + "id="
				+ '"discount_won"' + "required=" + '"required"' + "/>"
	}
	$("#discount_type").html(discount_type_str);
}
//대분류 선택시, 소분류 자동변환
function big_cate_Change() {
	var big_num_value = $("#big_category > option:selected").val();
	
		$.ajax({
				url : "/manager/manager_cardRegister_small",
				type : "get",
				data : {
					"big_num" : $("#big_category > option:selected").val()
				},
				success : function(responseData) {

					var count = Object.keys(responseData).length;
					var str = "";
					for (var i = 0; i < count; i++) {
						str += "<option id='card_small_name_"+responseData[i].small_num+"' value=" + responseData[i].small_num + ">"
								+ responseData[i].small_name + "</option>";
					}
					$("#small_category").html(str);
				}
			});
}
function fnDel(id){
	dc_num = $(id).attr("name");
	card_code = $("#cardcode").val();
	if(confirm("정말 삭제하시겠습니까?")){
		//location.href ="/manager/manager_deleteDisCard?dc_smallnum="+dc_smallnum+"&dc_cardcode="+dc_cardcode;
		
		var CardDiscountDto = new Object;
		CardDiscountDto.dc_num=dc_num;
		CardDiscountDto.dc_cardcode=card_code;

		list.push(CardDiscountDto);
		
		$.ajax({
			url : "/manager/manager_deleteDisCard",
			method : "POST",
			type: "json",
		    contentType: "application/json;",
			data : JSON.stringify(list),
			success:(function(responseData) {
					if(responseData == "success"){
						$("#"+dc_num).remove();
						console.log("디스카운트 삭제 성공");
						alert("디스카운트정보 삭제 성공");


					}
					else
						{
						console.log("디스카운트정보저장 실패");
						}
			})
		});
	}
}
function fnCor(num, sname, code, snum){
	$("#cor_space1").css("display", "block");
	$("#cor_space2").css("display", "block");
	$("#card_reg_step2").css("display", "block");

	$("#add_space1").css("display", "none");
	$("#add_space2").css("display", "none");
	$("#card_reg_step3").css("display", "none");
	
	$("#input_dbCor").css("display", "block");
	$("#input_dbAdd").css("display", "none");
	dc_cornum = num;
	dc_corname = sname;
	dc_corcardcode = code;
	dc_corsmallnum = snum;
	correctItem = "할인번호-"+num;
	$("#cor_target").text(correctItem);

	//location.href ="/manager/manager_updateDisCard?small_num="+small_num;
}
function fnAdd(){
	dc_cardcode = $("#cardcode").val();
	
	$("#add_space1").css("display", "block");
	$("#add_space2").css("display", "block");
	$("#card_reg_step3").css("display", "block");
	
	$("#cor_space1").css("display", "none");
	$("#cor_space2").css("display", "none");
	$("#card_reg_step2").css("display", "none");
	
	
	$("#input_dbAdd").css("display", "block");
	$("#input_dbCor").css("display", "none");
}
function input_dbCor(){
	if(dc_num != ""){
		$.ajax({
			url : "/manager/manager_updateDisCard",
			method : "POST",
			type: "json",
		    contentType: "application/json;",
			data : JSON.stringify(list),
			success:(function(responseData) {
					if(responseData == "success"){
						alert("디스카운트정보 수정 성공");
						$("#"+dc_num).remove();
						
						var innerHtml = '<tr id="'+dc_num+'">'+
											'<td>'+dc_num+'</td><td>'+card_small_name+'</td><td>'+dc_value+'</td><td>'+dc_classify+'</td>'+
											'<td>'+dc_min+'</td><td>'+dc_max+'</td><td>'+dc_etc+'</td>'+
											'<td><input type ="button" class ="btn" value ="삭제" id= "btn" name="'+dc_num+'" onclick="javascript:fnDel(this)"/></td>'+
											'<td><input type ="button" class ="btn" value ="수정" id= "btn" name="'+dc_num+'" onclick="javascript:fnCor(\"'+dc_num+'\", \"'+card_small_name+'\", \"'+dc_cardcode+'\", \"'+dc_smallnum+'\")"/></td>'+
										'</tr>';
						
							
							
						$("#mngTable").append(innerHtml)
					}
					else{
						console.log("디스카운트정보 수정 실패");
					}
			})
		});		
	}else{
		alert("수정버튼을 반드시 눌러주십시오.")
	}
}
function input_dbAdd(){
	
	$.ajax({
		url : "/manager/manager_addDisCard",
		method : "POST",
		type: "json",
	    contentType: "application/json;",
		data : JSON.stringify(list),
		success:(function(responseData) {
				if(responseData == "success"){
					alert("디스카운트정보 추가 성공");
					location.href ="/manager/manager_cardList";
				}
				else{
					console.log("디스카운트정보 추가 실패");
					alert("소분류에 중복된 데이터가 있습니다.");
				}
		})
	});
}
function complete(){
	location.href ="/manager/manager_cardList";
}
</script>
<style>
/*FileInput css 스타일 수정하기 */
.filebox label {
  display: inline-block;
  padding: .5em .75em;
  color: #ffffff;
  font-size: inherit;
  font-weight : bold;
  line-height: normal;
  vertical-align: middle;
  background-color: #8ba752;
  cursor: pointer;
  border: 1px solid #ebebeb;
  border-bottom-color: #e2e2e2;
  border-radius: .25em;
  margin-left: 20px;
}

.filebox input[type="file"] {  /* 파일 필드 숨기기 */
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip:rect(0,0,0,0);
  border: 0;
}
li{
	font-size: 20px;
	color :#97b162;
}
#titleFont{
	color :#97b162;
	font-size: 30px;
	font-weight:bold;
}
#titleHr{
	border: 1px solid #d4d1ca;
}

 #titleDiv{
	margin-left:100px;
 	margin-top:50px;
 }
 
 #mngTable {
 	margin-top :30px;
 	margin-left:80px;
 }

 #mngTable th{
	font-size: 20px;
	font-weight: bold;
	color:#5c554b;
	border-bottom: 1px solid #d4d1ca;
	padding-bottom: 10px;
 }
 #mngTable td{
 	height:50px;
 	width :200px;
 	text-align: center;
 	border-bottom: 1px solid #d4d1ca;
 	color:#5c554b;
 	font-size: 15px;
 }
 #btn:hover{
	background-color:#97b162;
	border: 0;
	outline: 0;
}

#btn {
	width : 80px;
	display: inline-block;
	padding: 6px 12px;
	margin-top: 5px;
	margin-bottom: 0;
	font-size: 14px;
	font-weight: bold;
	line-height: 1.42857143;
	text-align: center;
	white-space: nowrap;
	vertical-align: middle;
	-ms-touch-action: manipulation;
	touch-action: manipulation;
	cursor: pointer;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
	background-image: none;
	background-color:#8ba752;
	color:#ffffff; 
	border: 1px solid transparent;
	border-radius: 4px;
	border: 0;
	outline: 0;
}
.btn-style {
	width : 80px;
	display: inline-block;
	padding: 6px 12px;
	margin-top: 5px;
	margin-bottom: 0;
	font-size: 14px;
	font-weight: bold;
	line-height: 1.42857143;
	text-align: center;
	white-space: nowrap;
	vertical-align: middle;
	-ms-touch-action: manipulation;
	touch-action: manipulation;
	cursor: pointer;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
	background-image: none;
	background-color:#8ba752;
	color:#ffffff; 
	border: 1px solid transparent;
	border-radius: 4px;
	border: 0;
	outline: 0;
}
 .btn-style2 {
	width : 200px;
	display: inline-block;
	padding: 6px 12px;
	margin-top: 5px;
	margin-bottom: 0;
	font-size: 14px;
	font-weight: bold;
	line-height: 1.42857143;
	text-align: center;
	white-space: nowrap;
	vertical-align: middle;
	-ms-touch-action: manipulation;
	touch-action: manipulation;
	cursor: pointer;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
	background-image: none;
	background-color:#8ba752;
	color:#ffffff; 
	border: 1px solid transparent;
	border-radius: 4px;
	border: 0;
	outline: 0;
}
</style>
</head>
<body style ="background-color: #f5f4f0">
<jsp:include page="/WEB-INF/views/common/mng_header.jsp"></jsp:include>
<input type="hidden" id="cardcode" value="${discard[0].dc_cardcode }">
<div class="container">
		<div class="row">
			<div class="span12" id ="titleDiv">
				<ul>
					<li>
						<font id ="titleFont">STEP 2 : 카드할인정보수정</font>
					</li>
				</ul>
				<hr id ="titleHr"/>
			</div>
		</div>
	</div>
	<div class ="container">
		<div class ="row">
			<div class="span12" id ="titleDiv" style="margin-top: -20px">
				<h3 class="text-success">카드할인정보 리스트</h3>
			</div>
			<div class ="span12" id ="tableDiv">
				<table id ="mngTable">
					<tr>
						<th>할인번호</th><th>소분류</th><th>할인금액</th><th>할인타입</th><th>최소결제</th><th>최대할인</th><th>기타사항</th>
						<th></th><th></th>
					</tr>
					<c:forEach items="${discard }" var="dis">
					<tr id="${dis.dc_num }">
						<td>${dis.dc_num}</td><td>${dis.small_name }</td><td>${dis.dc_value }</td><td>${dis.dc_classify }</td>
						<td>${dis.dc_min }</td><td>${dis.dc_max }</td><td>${dis.dc_etc }</td>
						<td><input type ="button" class ="btn" value ="삭제" id= "btn" name="${dis.dc_num }" onclick="javascript:fnDel(this)"/></td>
						<td><input type ="button" class ="btn" value ="수정" id= "btn" name="${dis.dc_num }" onclick="javascript:fnCor('${dis.dc_num}', '${dis.small_name }', '${dis.dc_cardcode }', '${dis.dc_smallnum }')"/></td>
					</tr>
					</c:forEach>
				</table>
			</div>
			<div class="span12" style="text-align: right;" >	
				<input class="btn-style" type="button" value="추가하기" onclick="fnAdd()" style="margin-right: 20px; width: 22%;">
			</div>
			<div class="span12" id ="titleDiv">
				<h4 id="cor_space1" style="display: none;" class="text-info">아래 입력창에서 선택한 항목을 수정할 수 있습니다.</h4>
				<h3 id="cor_space2" style="display: none;" class="text-warning">수정항목 : <span id="cor_target"></span></h3>
				<h4 id="add_space1" style="display: none;" class="text-info">아래 입력창에서 항목을 추가할 수 있습니다.</h4>
				<h3 id="add_space2" style="display: none;" class="text-warning">항목 추가하기 설정 상태</h3>
			</div>
			<div class="span4" id ="tableDiv" style="margin-left: 100px; border-right: #cfcfcf solid 1px;">
			<h5 class="text-info"><span class="label label-info">STEP 1</span>대분류 선택</h5>
				<select name="select_big" id="big_category">
					<c:forEach items="${bigcategories }" var="bigC">
						<option value="${bigC.big_num }">${bigC.big_name }</option>
					</c:forEach>
				</select>
			<h5 class="text-info"><span class="label label-info">STEP 2</span>소분류 선택</h5>
				<select name="select_small" id="small_category"></select>
			<h5 class="text-info"><span class="label label-info">STEP 3</span>카드할인정보</h5>
			<h5 class="label inline">할인금액 정보입력</h5>
				<label class="radio inline" for="r_discount1"><input type="radio"  name="dis_chk" id="r_discount1" value="0"/><span>(%)</span></label>			
				<label class="radio inline" for="r_discount2"><input type="radio" name="dis_chk" id="r_discount2" value="1" checked/><span>(원)</span></label>
			<div id="discount_type" class="controls"></div>
			<h5 class="label inline">최소 결제금액 입력</h5>					
			<div class="controls">
				<input type="number" min="0" max="1000000" id="min_paid" placeholder="최소결제금액을 입력하세요." required="required" />
			</div>
			<h5 class="label inline">최대 할인금액 입력</h5>					
			<div class="controls">
				<input type="number" min="0" id="max_discount" placeholder="최대할인금액을 입력하세요." required="required" />
			</div>					
			<h5 class="label inline">기타정보입력</h5>
			<div class="controls">
				<input type="text" id="etc_data" placeholder="기타정보를 입력하세요." />
			</div>
			<br/>
			<div>
				<input class="btn-style" style="width: 27%;" type="button" id="card_clear_step2" value="초기화" >
				<input class="btn-style" style="display: none;" type="button" id="card_reg_step2" value="수정적용"/>
				<input class="btn-style" style="display: none;" type="button" id="card_reg_step3" value="추가적용"/>
				<input class="btn-style" style="display: none;" type="button" id="input_dbCor" value="수정완료" onclick="input_dbCor()">
				<input class="btn-style" style="display: none;" type="button" id="input_dbAdd" value="추가완료" onclick="input_dbAdd()">
			</div>
		</div>
		<div class="span6">
			<div class="text text-danger" role="text" style="border: #cfcfcf solid 1px; padding: 10px; margin-left:40px;">
			<span class="icon glyphicon-exclamation-sign"></span>
				<dl>
				  <dt style="font-size:15pt; color:black">카드 수정시 주의사항</dt><br/>
				  <dd style="font-size:13pt; color:#de5a69">1. 단일항목으로 삭제와 수정이 가능함</dd>
				  <dd style="font-size:13pt; color:#de5a69">2. 항목 수정시 반드시 수정버튼 클릭해야함</dd>
				  <dd style="font-size:13pt; color:#de5a69">3. 항목 추가시 추가하기 버튼을 클릭해야함</dd>
				  <dd style="font-size:13pt; color:#de5a69">4. 항목을 추가하면 카드리스트로 이동함</dd>
				  <dd style="font-size:13pt; color:#de5a69">5. 중복된 소분류는 DB에 저장되지 않음</dd>
				</dl>
			</div>
			<h4 style="margin-left:30px;">카드할인정보</h4>
			<table class="table table-bordered" style="margin-left:30px;">
				<tbody>
				<tr>
					<th class="span1">카드혜택</th>
					<td class="span4">
						<table class="table table-striped nanum">
							<tbody id="table_step2"></tbody>
						</table>
					</td>
				</tr>
				</tbody>
			</table>
			</div>
		</div>
	<br/>
	<hr id ="titleHr"/>
	<br/>
	<div class="span12" style="margin-bottom: 30px;">
		<div class="row">
			<div class="span12" align="center"><h4 style="color:dark-gray">아래의 버튼을 누르면 카드리스트로 이동합니다.</h4></div>
			<div class="span4"></div>
			<div class="span6" align="center">
				<div class="span2"><button class="btn-style2 btn-large" type="button" onclick="complete()">카드리스트로</button></div>	
			</div>
			<div class="span2"></div>
		</div>
	</div>
	</div>
</body>
</html>