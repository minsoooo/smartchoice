<!-- 
	일   시 : 2016.07.31
	작성자 : 배효열
	내   용 : 카드기본정보 수정 뷰 페이지
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
<title>카드기본정보수정</title>
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css" />
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script src="/resources/plugins/jQuery/jquery.form.min.js"></script>
<script src="/resources/plugins/js/array.js"></script>
<script>
$(function($){
	companyData_Change();
	card_type_Check();
	//기본카드정보 : 1단계 적용 버튼
	$("#card_reg_step1").bind("click", card_reg_step1_Click);
	$("#card_clear_step1").bind("click", card_clear_step1_Click);
	
	//기본카드정보 : 카드타입 선택(credit/check)
	$("#r_type1").bind("click", r_type1_Click);
	$("#r_type2").bind("click", r_type2_Click);
	
	//이미지 미리보기 사이즈
	$("#imgSpace").css("width","300px").css("height","175px");
	$("#imgPre").css("width","300px").css("height","175px");
	
	//사진 업로드 전 미리보기
	var opt = {
	        img: $('#imgPre'),
	        w: 300,
	        h: 175
	    };
	 
	$('#input_file').setPreview(opt);
});

var card_name;
var card_annualfee
var card_lastrecord;
var card_typeflag;
var card_useflag;
var card_compnum;
var card_img;
var card_code="";
var max_num;


//카드 이미지 미리보기
$.fn.setPreview = function(opt){
	"use strict"
		var defaultOpt = {
			inputFile : $(this),
			img : null,
			w : 300,
			h : 200
		};
		$.extend(defaultOpt, opt);

		var previewImage = function() {
			if (!defaultOpt.inputFile || !defaultOpt.img)
				return;

			var inputFile = defaultOpt.inputFile.get(0);
			var img = defaultOpt.img.get(0);
			
			// FileReader
			if (window.FileReader) {
				// image 파일만
				console.log(inputFile.files[0]);
				if (!inputFile.files[0].type.match(/image\//))
					return;

				// preview
				try {
					var reader = new FileReader();
					reader.onload = function(e) {
						//console.log(e.target.result);
						img.src = e.target.result;
						card_img = e.target.result;
						img.style.width = defaultOpt.w + 'px';
						img.style.height = defaultOpt.h + 'px';
						img.style.display = '';
					}
					/*
					reader.onloadend=function()
					{
						
	
					}
					*/
					reader.readAsDataURL(inputFile.files[0]);
				} catch (e) {
					//alert(e);
					// exception...
				}
				// img.filters (MSIE)
			} else if (img.filters) {
				inputFile.select();
				inputFile.blur();
				var imgSrc = document.selection.createRange().text;

				img.style.width = defaultOpt.w + 'px';
				img.style.height = defaultOpt.h + 'px';
				img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\""
						+ imgSrc + "\")";
				img.style.display = '';
				// no support
			} else {
				// Safari5, ...
			}
		};
		// onchange
		$(this).change(function() {
			previewImage();
		});
	};

	function card_type_Check(){
		card_typeflag = $("#hidden_card_typeflag").val();
		if(card_typeflag == 0){		
			$("input[name='type_chk']").eq(0).prop("checked", true);
		}else{
			$("input[name='type_chk']").eq(1).prop("checked", true);
		}
	}
	
	//1단계 적용버튼 클릭시 기본정보확인 테이블에 텍스트 삽입
	function card_reg_step1_Click() {
		useflag = $("#hidden_card_useflag").val();
	
		//카드종류
		card_typeflag = $('input[name="type_chk"]:checked').val();
		if (card_typeflag == "0") {
			card_annualfee = $("#card_annualfee").val();
			$("#table_card_annualfee").html(card_annualfee);
		} else {
			card_annualfee = $("#card_annualfee").val();
			$("#table_card_annualfee").html(card_annualfee);
		}
		//카드명
		card_name = $("#card_name").val();

		//카드사명, 카드사넘버
		card_compnum = $("select[name='card_comp'] > option:selected").val();
		
		var card_compname = $('#card_comp_name_' + card_compnum).text();
		
		//연회비
		card_annualfee = $('#card_annualfee').val();

		//전월실적
		card_lastrecord = $('#card_record').val();
		
		card_code = $("#table_card_code").text();
		
		$("#table_card_type").html(card_typeflag == "0" ? "신용카드" : "체크카드");//카드정보확인에 카드타입 출력	
		$("#table_card_name").html(card_name);//카드정보확인에 카드명 출력
		$("#table_card_comp").html(card_compname);//카드사 번호에 대한 카드사 이름을 카드정보확인에 출력
		$("#table_card_record").html(card_lastrecord);//전월실적
		$("#table_card_anuualfee").html(card_annualfee);//연회비
		alert("입력하신 항목이 적용되었습니다.");
	}
	//카드기본정보 : 1단계 기본정보 초기화 버튼
	function card_clear_step1_Click() {
		$('#table_step1 tbody td').text("");//정보 테이블 초기화

		//정보 밸류값 초기화
		var set_bank1 = $("select[name='card_comp'] option").eq(0).val();
		$("select[name='card_comp']").val(set_bank1);
		$('#card_name').val("");
		$('#card_record').val("");
		$("input[name='type_chk']").eq(0).prop("checked", true);//초기화 버튼 클릭시 신용카드로 리턴
		$('#card_annualfee').val("");
	}

	//신용카드 선택시 연회비 활성화
	function r_type1_Click() {
		$("#card_annualfee").css("visibility", "visible");
		$("#text_annual").css("visibility", "visible");
	}
	//체크카드 선택시 연회비 비활성화 및 연회비 기본값 '0'으로 설정
	function r_type2_Click() {
		if ($("#r_type2").is(":checked") == true) {
			$("#card_annualfee").css("visibility", "hidden");
			$("#text_annual").css("visibility", "hidden");
			$("#card_annualfee").val("0");
		}
	}
function companyData_Change(){
	//기존 데이터 세팅 : 카드사 selecteBox
	var comp_selected = $("#table_card_comp").text();
	$('select[name="card_comp"]').val(comp_selected).prop("selected", true);
	//기존 데이터 세팅 : 카드사 테이블 
	var table_compnum = $("select[name='card_comp'] > option:selected").val();
	var table_compname = $('#card_comp_name_' + table_compnum).text();
	$("#table_card_comp").text(table_compname);
	
	//기존 데이터 세팅 : 카드명 입력창
	var text_card_name = $("#table_card_name").text();
	$("#card_name").val(text_card_name);
	//기존 데이터 세팅 : 전월실적 입력창
	var text_card_record = $("#table_card_record").text();
	$("#card_record").val(text_card_record);
	//기존 데이터 세팅 : 연회비 입력창 
	var text_card_annualfee = $("#table_card_annualfee").text();
	$("#card_annualfee").val(text_card_annualfee);
	
}
function updateCard(){
	if(card_code==""){
		alert("적용버튼은 반드시 눌러야합니다.");
	}else{
		
		var dto = 
		{
			"card_typeflag":card_typeflag,
			"card_useflag":card_useflag,
			"card_compnum":card_compnum, 
			"card_name":card_name,
			"card_lastrecord":card_lastrecord,
			"card_annualfee":card_annualfee,
			"card_code":card_code
		};
	
		$.ajax({
			url : "/manager/manager_cardCor",
			method : "POST",
			type: "json",
		    contentType: "application/json;",
			data : JSON.stringify(dto),
			success:(function(responseData) {
				if(responseData == "success"){
					alert("수정이 완료되었습니다.");
					$("#hidden_card_code").val(card_code);
					$("#card_image").submit();
				}
				else{
					console.log("카드정보수정 실패");
				}
			})
		});
	}
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
#titleFont{
	color :#97b162;
	font-size: 30px;
	font-weight:bold;
}
#titleHr{
	border: 1px solid #d4d1ca;
}

 #titleDiv{
	margin-left:10px;
 	margin-top:50px;
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
<input type="hidden" id="hidden_card_useflag" name="hidden_card_useflag" value="${card_info.card_useflag }"/>
<input type="hidden" id="hidden_card_typeflag" name="hidden_card_typeflag" value="${card_info.card_typeflag }"/>
<div class="container">
	<div class="span12" id ="titleDiv">
		<ul>
			<li>
				<font id ="titleFont">STEP 1 : 카드기본정보수정</font>
			</li>
		</ul>
		<hr id ="titleHr"/>
	</div>
	<div class="container">	
		<div class="row">
			<div class="span12">
				<h3 class="text-success">아래의 각 항목에 수정할 데이터를 입력해주세요.</h3>
			</div>
			
			<div class="span12" style="border: #cfcfcf solid 1px; padding: 10px;">
				<div class="row">
					<div class="span5" style="border-right: #cfcfcf solid 1px;">
						<h5 class="text-info"><span class="label label-info">STEP 1</span>카드 종류 선택</h5>
							<label class="radio inline" for="rtype1"><input type="radio" name="type_chk" id="r_type1" value="0"/>신용카드</label>
							<label class="radio inline" for="rtype2"><input type="radio" name="type_chk" id="r_type2" value="1"/>체크카드</label>						
						<br/><br/>
						<h5 class="text-info"><span class="label label-info">STEP 2</span>카드사 선택</h5>
							<select name="card_comp">
								<c:forEach items="${companies }" var="CardDto">
									<option id="card_comp_name_${CardDto.comp_num }" value="${CardDto.comp_num }">${CardDto.comp_name }</option>
								</c:forEach>
							</select>
						<br/><br/>
						<h5 class="text-info"><span class="label label-info">STEP 3</span>카드명 입력</h5>
							<input class="input-large" type="text" placeholder="Enter the CardName" required="required" id="card_name" name="card_name"/>
						<br/><br/>
						<h5 class="text-info"><span class="label label-info">STEP 4</span>전월실적 입력</h5>
								<input class="input-large" type="number" min="0" placeholder="Enter the Number" required="required" id="card_record"/>				
						<br/><br/>
						<h5 id="text_annual" class="text-info"><span class="label label-info">STEP 5</span>연회비 입력</h5>
							<input class="input-large" type="number" min="0" max="100000" id="card_annualfee" placeholder="Enter the Number" required="required" />
						<br/><br/>
						<div>
							<input class="btn-style" type="button" id="card_reg_step1" value="적  용"/>
							<input class="btn-style" type="button" id="card_clear_step1" value="초기화"/>
						</div>
					</div>
					<div class="span6">
						<h4 style="margin-left:30px;">카드기본정보</h4>
						<table id="table_step1" class="table table-bordered" style="margin-left:30px;">
							<tbody id="step1_table" class="table-hover">
								<tr><th class="span1">카드사명</th>
									<td class="span3" id="table_card_comp">${card_info.card_compnum}</td>
								</tr>
								<tr><th>카드종류명</th>
									<td id="table_card_type">
										<c:if test="${card_info.card_typeflag == 0}">
											신용카드
										</c:if>
										<c:if test="${card_info.card_typeflag == 1}">
											체크카드
										</c:if>
									</td>
								</tr>
								<tr><th>카드명</th>
									<td id="table_card_name">${card_info.card_name }</td>
								</tr>
								<tr><th>전월실적(원)</th><td id="table_card_record">${card_info.card_lastrecord }</td></tr>
								<tr><th>연회비(원)</th><td id="table_card_annualfee">${card_info.card_annualfee}</td></tr>
								<tr><th>카드고유번호</th><td id="table_card_code">${card_info.card_code}</td></tr>							
							</tbody>
						</table>
						<form id="card_image" name="card_image" method="post" action="/manager/manager_cardCorImg" enctype="multipart/form-data">
						<input type="hidden" id="hidden_card_code" name="hidden_card_code" value="${card_info.card_code}"/>
						<h4 style="margin-left:30px;">카드이미지 미리보기</h4>
						<table style="margin-left:30px;">
							<tr><td id="imgSpace"><img id ="imgPre" src ="/resources/images/card/${card_info.card_img }"/></td></tr>
							<tr>
							<td>
								<div class="filebox">
									<label for="input_file">카드이미지 등록</label>
									<input class="btn-style" type="file" id="input_file" name ="input_file"> 
								</div>
							</td>
							</tr>
						</table>
						</form>
					</div>
				<br/>
				</div>				
			</div>

			<div class="span12" style="margin-bottom: 30px;">
				<div class="row">
				<br/><br/>
					<div class="span12" align="center"><h4 style="color:dark-gray">이미지 등록과 적용버튼은 반드시 누르셔야합니다.</h4></div>
					<div class="span4"></div>
					<div class="span6" align="center">
						<div class="span2"><button class="btn-style2 btn-large" type="button" onclick="updateCard()">다음 단계로</button></div>	
					</div>
					<div class="span2"></div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>