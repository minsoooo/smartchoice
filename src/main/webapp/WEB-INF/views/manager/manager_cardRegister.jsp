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
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@page import="java.util.ArrayList"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<title>카드등록</title>
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css" />
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script src="/resources/plugins/jQuery/jquery.form.min.js"></script>
<script src="/resources/plugins/js/array.js"></script>
<script>
$(function(){
	//대분류 버튼
	$("#big_category").bind("change", big_cate_Change);
	big_cate_Change();

	//기본카드정보 : 1단계 적용 버튼
	$("#card_reg_step1").bind("click", card_reg_step1_Click);
	$("#card_clear_step1").bind("click", card_clear_step1_Click);
	
	//카드할인정보 : 2단계 적용 버튼
	$("#card_reg_step2").bind("click", card_reg_step2_Click);
	$("#card_clear_step2").bind("click", card_clear_step2_Click);
	
	//기본카드정보 : 카드타입 선택(credit/check)
	$("#r_type1").bind("click", r_type1_Click);
	$("#r_type2").bind("click", r_type2_Click);
	
	//카드할인정보 : 할인타입 선택(per/won)
	$("#r_discount1").bind("click", r_discount1_Click);
	$("#r_discount2").bind("click", r_discount2_Click);
	r_discount2_Click();

	//이미지 미리보기 사이즈
	$("#imgSpace").css("width","340px").css("height","190px");
	$("#imgPre").css("width","340px").css("height","190px");
	
	//사진 업로드 전 미리보기
	var opt = {
	        img: $('#imgPre'),
	        w: 340,
	        h: 190
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
var card_code;
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
					reader.onloadend=function()
					{
						//console.log(card_img);
	
					}
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

	//1단계 적용버튼 클릭시 기본정보확인 테이블에 텍스트 삽입
	function card_reg_step1_Click() {
		//카드활성화
		card_useflag = 1;
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
		max_num = $("#table_card_code").text();
		
		//카드코드 조합 : 카드사 +카드넘버
		card_code = card_compnum + "_" + max_num;
		alert("1단계 기본카드 코드 확인:"+card_code);

		$("#table_card_type").html(card_typeflag == "0" ? "신용카드" : "체크카드");//카드정보확인에 카드타입 출력	
		$("#table_card_name").html(card_name);//카드정보확인에 카드명 출력
		$("#table_card_comp").html(card_compname);//카드사 번호에 대한 카드사 이름을 카드정보확인에 출력
		$("#table_card_record").html(card_lastrecord);//전월실적
		$("#table_card_record").html(card_lastrecord);//전월실적
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

	//Array.js 를 제작하여 ArrayList를 사용할 수 있도록 자바코드화함
	var card_option_text = "";//선택한 데이터가 여러 개일 경우, 모든 데이터를 담도록 변수선언 
	var option_small_val = new ArrayList();//선택한 소분류 밸류
	var option_type = new ArrayList();//입력한 카드할인 퍼센트/원
	var option_discount = new ArrayList();//입력한 카드할인밸류
	var option_min = new ArrayList();//입력한 최소결제금액
	var option_max = new ArrayList();//입력한 최대할인한도
	var option_etc = new ArrayList();//기타사항

	var list = new Array();
	//2단계 적용버튼 클릭시 할인정보 테이블에 텍스트 삽입
	function card_reg_step2_Click() {
			 	
		var dc_value = 0;
		var dc_min = $("#min_paid").val();
		var dc_max = $("#max_discount").val();
		var dc_etc = $("#etc_data").val();
		var dc_cardcode = card_code;
		var dc_smallnum = $("select[name='select_small'] > option:selected").val();
		var card_small_name = $("#card_small_name_" + dc_smallnum).text();

		//카드할인정보 : 할인타입-DB에 저장될 데이터값
		var dc_classify = $('input[name="dis_chk"]:checked').val();
		//카드할인정보 : 할인타입-사용자에게 출력될 데이터값
		var dis_type
		if (dc_classify == 0) {
			dc_value = $("#discount_per").val();
			dis_type = "percent";
		} else {
			dc_value = $("#discount_won").val();
			dis_type = "won";
		}		

		alert("2단계 카드할인 코드확인:" + dc_cardcode);
		
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
		CardDiscountDto.dc_smallnum=dc_smallnum;
		CardDiscountDto.dc_classify=dc_classify;
		CardDiscountDto.dc_value=dc_value;
		CardDiscountDto.dc_min=dc_min;
		CardDiscountDto.dc_max=dc_max;
		CardDiscountDto.dc_etc=dc_etc;
		CardDiscountDto.dc_cardcode=card_code;

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

		option_small_val = new ArrayList();//초기화시 새롭게 데이터를 받을 수 있도록 인스턴스생성
		list = null;//초기화시 리스트 초기화
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
	function input_db(){

		var dto = 
				{
					"card_typeflag":card_typeflag, 
					"card_compnum":card_compnum, 
					"card_name":card_name,
					"card_lastrecord":card_lastrecord,
					"card_annualfee":card_annualfee,
					"card_code":card_code
				};


		$.ajax({
			url : "/manager/manager_cardRegisterDto",
			method : "POST",
			type: "json",
		    contentType: "application/json;",
			data : JSON.stringify(dto),
			success:(function(responseData) {
				if(responseData == "success"){
					console.log("카드정보저장 성공");

					$.ajax({
						url : "/manager/manager_cardRegisterList",
						method : "POST",
						type: "json",
					    contentType: "application/json;",
						data : JSON.stringify(list),
						success:(function(responseData) {
								if(responseData == "success"){
									console.log("디스카운트정보저장 성공");
									$("#hidden_card_code").val(card_code);
									$("#card_image").submit();
								}
								else
									{
									console.log("디스카운트정보저장 실패");
									}
						})
					});
				}
				else{
					console.log("카드정보저장 실패");
				}
			})
		});
	}
</script>
<style>
	/*FileInput css 스타일 수정하기 */
					.filebox label {
					  display: inline-block;
					  padding: .5em .75em;
					  color: #F6F6F6;
					  font-size: inherit;
					  font-weight : bold;
					  line-height: normal;
					  vertical-align: middle;
					  background-color: #008299;
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
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<div class="container">
	<div class="span12">
		<h1>신규카드정보등록<small>$mart Choice</small></h1>
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
					<div class="span5" style="border-right: #cfcfcf solid 1px;">
						<h5 class="text-info"><span class="label label-info">STEP 1</span>카드 종류 선택</h5>
							<label class="radio inline" for="rtype1"><input type="radio" name="type_chk" id="r_type1" value="0" checked="checked"/>신용카드</label>
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
							<button class="btn btn-success btn-large pull-left" type="button" id="card_reg_step1">기본정보적용</button>	
							<button class="btn btn-danger btn-large pull-left" type="button" id="card_clear_step1">초기화</button>
						</div>
					</div>
					<div class="span6">
						<h4 style="margin-left:30px;">카드기본정보</h4>
						<table id="table_step1" class="table table-bordered" style="margin-left:30px;">
							<tbody id="step1_table" class="table-hover">
								<tr><th class="span1">카드사명</th><td class="span3" id="table_card_comp">카드사명을 선택해주세요.</td></tr>
								<tr><th>카드종류명</th><td id="table_card_type">카드종류를 선택해주세요.</td></tr>
								<tr><th>카드명</th><td id="table_card_name">카드명을 입력해주세요.</td></tr>
								<tr><th>전월실적(원)</th><td id="table_card_record">전월실적을 입력해주세요.</td></tr>
								<tr><th>연회비(원)</th><td id="table_card_annualfee">연회비를 입력해주세요.</td></tr>
								<tr><th>카드코드</th><td id="table_card_code">생성될 카드의 고유번호 : 카드사_${code+1}</td></tr>							
							</tbody>
						</table>
						<form id="card_image" name="card_image" method="post" action="/manager/manager_cardRegisterDto2" enctype="multipart/form-data">
						<input type="hidden" id="hidden_card_code" name="hidden_card_code" value=""/>
						<h4 style="margin-left:30px;">카드이미지 미리보기</h4>
						<table style="margin-left:30px;">
							<tr><td id="imgSpace"><img id ="imgPre" src ="/resources/images/creditcard.jpg"/></td></tr>
							<tr>
							<td>
								<div class="filebox">
									<label for="input_file">카드이미지 등록</label><input type="file" id="input_file" name="input_file"><br/>
								</div>
							</td>
							</tr>
						</table>
						</form>
					</div>
				<br/>
				</div>				
			</div>
		
			<div class="span6">
				<h3 class="text-success"><span class="badge badge-success">2</span>카드혜택정보</h3>
			</div>
			<div class="span12" style="border: #cfcfcf solid 1px; padding: 10px;">
				<div class="row">
					<div class="span5" style="border-right: #cfcfcf solid 1px;">
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
							<button class="btn btn-success btn-large pull-left" type="button" id="card_reg_step2">할인정보적용</button>	
							<button class="btn btn-danger btn-large pull-left" type="button" id="card_clear_step2">초기화</button>
						</div>
					</div>
					<div class="span6">
					<div class="text text-danger" role="text" style="border: #cfcfcf solid 1px; padding: 10px; margin-left:40px;">
					<span class="icon glyphicon-exclamation-sign"></span>
						<dl>
						  <dt style="font-size:13pt; color:red">카드 등록시 주의사항</dt><br/>
						  <dd>1. 카드는 기본정보와 할인정보, 총 2단계로 나뉘어 진행</dd>
						  <dd>2. 기본정보는 카드명, 카드종류, 전월실적, 연회비로 구성</dd>
						  <dd>3. 할인정보는 고유의 할인혜택을 포함, 복수등록이 가능</dd>
						  <dd>4. 단, 소분류 중복등록은 불가능</dd>
						  <dd>5. 확인버튼 누르기 전 출력된 테이블 재확인</dd>
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
			</div>
			<!-- 비어있는 span div는  간격조절용 -->
			<div class="span12">
				<div class="row">
				<br/><br/>
					<div class="span1"></div>
					<div class="span11" align="center"><h4 style="color:dark-gray">등록할 카드의 정보를 확인하고 아래 확인 버튼을 눌러주세요.</h4></div>
					<div class="span4"></div>
					<div class="span6" align="center">
						<div class="span2"><button class="btn-block btn-primary btn-large" type="button" onclick="input_db()">확인</button></div>	
						<div class="span2"><button class="btn-block btn-danger btn-large" type="button" value="적용" id="btn1">취소</button></div>
					</div>
					<div class="span2"></div>
				</div>
			</div>
		</div>
	<br/><hr/><br/><br/>
	</div>
</div>
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
</body>
</html>
