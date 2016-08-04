<!-- 
	카드추천 소비 패턴리스트 페이지  
		소비패턴을 통한, 회원의 관심사를 통한 카드추천 선택
	작성일 : 2016-07-18
	수정일 : 2016-08-04
	작성자 : 김상덕
	cardPlan Snapshot 2.0 by.santori
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page session="true" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<title>plan Intro</title>
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css" />
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script>
var result=[];
function imgover(small_num){
	
	var imgid = "#img"+small_num;
	$(imgid).css("display","none");
	var stable = "#table"+small_num;
	$(stable).css("display","block");
	
}
function imgout(small_num){
	var stable = "#table"+small_num;
	$(stable).css("display","none");
	var imgid = "#img"+small_num;
	$(imgid).css("display","block");
	
}
//var list = new Array();
function tdclick(money, small_name, small_num){
	useEtcMoney(money, small_num);
	$("#usemoneyMessage").empty();//메세지 삭제
	var useMoneyTr = "#useMoneyTr"+small_num;
	var useMoneyTdName = "#useMoneyTdName"+small_num;
	if($(useMoneyTdName).attr("id")){//같은종목에서 다른금액을 선택한경우
		$(useMoneyTr).remove();
	}
	var insertUseMoney = "<tr id='useMoneyTr"+small_num+"' onclick=useMoneyTdDelete("+small_num+","+money+") onmouseover=showDelete("+small_num+") onmouseout=showNotDelete("+small_num+")>"
						+"<td id='useMoneyTdName"+small_num+"' name='"+small_name+"' style='width:180px;font-size:13px;'>"+small_name+"</td>"
						+"<td id='useMoneyTdNum"+small_num+"' name='"+small_num+"' style='width:180px;font-size:13px;display:none;'>"+small_num+"</td>"
						+"<td id='useMoneyTdMoney"+small_num+"' name='"+money+"'  style='width:80px; text-align:right;font-size:13px;' colspan='2'>"+money+"</td>"
						+"<td id='useMoneyDelete"+small_num+"' style='color:red;display:none'>X</td></tr>";
	$(insertUseMoney).appendTo("#usemoney");
	
	
	//패턴을 등록한 경우
	if($("#usemoneyMessage").text() == ""){
		//예상할인 금액 계산
		$.bestPlanMoney();
	}
	//패턴을 등록하지 않은 경우
	else{
		alert("패턴을 입력해 주세요");
	}
}
//예상 할인 금액 계산
$.bestPlanMoney=function(){
	var accountList = new Array();
	$("#usemoney tr").each(	// 목록의 개수만큼 실행
		function(){
			var obj = new Object();			// key, value 형태로 저장
			
			obj.plan_name = $(this).children("td:eq(0)").attr("name");
			obj.plan_num = $(this).children("td:eq(1)").attr("name");
			obj.plan_money = $(this).children("td:eq(2)").attr("name");
			obj.plan_cardtypeflag = $("#cardtypeflag").val();
			obj.plan_usemonthmoney = $("#usemonthmoney").val();
			if($("#useEtcMoney").text() < 0){
				obj.plan_useEtcMoney = 0 ;
			}else{
				obj.plan_useEtcMoney = $("#useEtcMoney").text();
			}
			accountList.push(obj);		// 정보를 Array에 추가
		}		
	);
	$.ajax({		// controller로 보냄
		url:"/planCard/planResult",
		type:"POST",
		data:JSON.stringify(accountList),	// json string형식
		dataType:"json",
		contentType: "application/json",
		success:function(data){
			$("#resultSaveMoneyTable").css("display","block");
			$("#resultSaveMoney").text(data[0]);
		}
	
	});	
}
function useMoneyTdDelete(small_num,money){
	var useMoneyTr = "#useMoneyTr"+small_num;
	useEtcMoney(money, small_num);
	$(useMoneyTr).remove();
	
	
	etcmoney = etcmoney + money;
	
	$("#useEtcMoney").empty();
	$("#useEtcMoney").append(etcmoney);
	$("#useEtcMoneyZero").empty();
	$("#useEtcMoneyZero").append("0");
	if(etcmoney<0){
		$("#useEtcMoney").css("display","none");
		$("#useEtcMoneyZero").css("display","block");
	}else{
		$("#useEtcMoney").css("display","block");
		$("#useEtcMoneyZero").css("display","none");
	}
	$.bestPlanMoney();
}
function showDelete(small_num){
	var useMoneyTr = "#useMoneyTr"+small_num;
	var useMoneyDelete = "#useMoneyDelete"+small_num;
	$(useMoneyTr).css("color", "red");
	$(useMoneyDelete).css("display", "block");
}
function showNotDelete(small_num){
	var useMoneyTr = "#useMoneyTr"+small_num;
	var useMoneyDelete = "#useMoneyDelete"+small_num;
	$(useMoneyTr).css("color", "#4e4a41");
	$(useMoneyDelete).css("display", "none");
}
//기타금액 계산
var etcmoney =0;
function useEtcMoney(money, small_num){
	var useMoneyTdMoney = "#useMoneyTdMoney"+small_num;
	if($("#useTotalMoney").text() == $("#useEtcMoney").text()){//처음 계산인경우
		etcmoney = $("#useTotalMoney").text() - money;
	}
	else{//처음계산이 아닌경우
		//etcmoney = $("#useEtcMoney").text();
		if($(useMoneyTdMoney).attr("id")){//같은종목에서 다른금액을 선택한경우
			etcmoney = Number($("#useEtcMoney").text()) + Number($(useMoneyTdMoney).text());
		}
		etcmoney = etcmoney - money;
	}
	$("#useEtcMoney").empty();
	$("#useEtcMoney").append(etcmoney);
	$("#useEtcMoneyZero").empty();
	$("#useEtcMoneyZero").append("0");
	if(etcmoney<0){
		$("#useEtcMoney").css("display","none");
		$("#useEtcMoneyZero").css("display","block");
	}else{
		$("#useEtcMoney").css("display","block");
		$("#useEtcMoneyZero").css("display","none");
	}
}
function tdover(money, small_num){
	var table_top = "#table_top"+small_num;
	var insertMoney = "<div style='text-align:right;width:80px;'>  "+money+"  </div>";
	$(table_top).empty();
	$(insertMoney).appendTo(table_top);
	
}
function tdout(small_num){
	var table_top = "#table_top"+small_num;
	$(table_top).empty();
}

function viewTextfield(small_num, small_name){
	var table_top = "#table_top"+small_num;
	//var table_top_textfiled = "#table_top_textfiled"+small_num;
	$(table_top).empty();
	var insertTextfiled = "<input type='textfield' id='table_top_textfiled' style='width:90px;' />  ";
	$(insertTextfiled).appendTo(table_top);
	$(table_top_textfiled).focus();
	
	$(function() {
		$('form').bind("keypress", function (e) {
			// textarea 제외
			if (event.target.nodeName != 'TEXTAREA') {
				//enter키만 먹음
				if (e.which == 13 || e.keyCode == 13) {
					tdclick($("#table_top_textfiled").val(), small_name, small_num);
					return e.keyCode != 13;
				}
			}
		});
	});
}
/*
function fnResult(){
	var demo=$("#usemoney").find("tr");
	var pppp=[];
	
	for(var i=0;i<demo.length;i++){
	//var trDemo=$("#usemoney tr:eq("+i+")").find("td:nth-child(1)").text();
	
	//console.log(i+"번째 값 확인:"+trDemo);
		
	pppp.push([
	           [i,$("#usemoney tr:eq("+i+")").find("td:nth-child(1)").text(),
	           $("#usemoney tr:eq("+i+")").find("td:nth-child(2)").text(),
	           $("#usemoney tr:eq("+i+")").find("td:nth-child(3)").text()]
	           ]);
	}
	location.href="/planCard/planResultView";
}
*/
$(document).ready(
	function(){
			
		$("span").click(
			function(){
				$("span").css("background-color", "").css("color", "");
				$(this).css("background-color", "#8ba752").css("color", "#fff");
				
				var tr =0;
				$("#smallTitle").empty();
				$("#smallList").empty();
				var blgclass_num = $(this).attr("value");
				
				$.get("/planCard/getSmallclass",{"blgclass_num":blgclass_num}).done(
					function(xmlData){
						var category = $(xmlData).find("category");
						if(category.length){
							$(category).each(
								function(){
									var big_name = $(this).find("big_name").text();
									if(tr == 0){
										var insertBigName ="<label style='width:150;height:30px; padding-top:10px;padding-left:10px;border-bottom:3px solid #8ba752;'>"+big_name+"</label>";
										$(insertBigName).appendTo("#smallTitle");
									}
									var small_num = $(this).find("small_num").text();
									var small_name = $(this).find("small_name").text();
									var category_img = "/resources/images/category/"+ $(this).find("small_img").text().trim();
									var moneyman = 10000;
									var insertCode =
											"<div style='width:178px;height:180px; border:1px solid #cffcf0; float:left;'  onmouseover='imgover("+small_num+")' onmouseout='imgout("+small_num+")'>"
												+"<div style='text-align:center; padding-top:10px;'><label>"+small_name+"<label></div>"
												+"<div>"
													+"<img id='img"+small_num+"' src='"+category_img+"' />"
												+"</div>"
												+"<table id='table"+small_num+"' style='border-top:1px solid #4e4a41; display:none; width:177px; text-align:center;'>"
													+"<tr style='width:177px;'>"
														+"<td colspan='3' style='height:30px;width:177px;'>"
															+"<label style='width:30px; float:left; padding-left:10px;'>월</label>"
															+"<div id='table_top"+small_num+"' style='float:left;'></div>"
															+"<label style='float:right; padding-right:20px;'>원</label>"
														+"</td>"
													+"</tr>"
													+"<tr style='border-top:1px solid #4e4a41;cursor:pointer;'>"
														+"<td id='td"+small_num+"_1'" + " onclick=tdclick("+10000+",'"+small_name+"','"+small_num+"')" + " onmouseover='tdover("+10000+","+small_num+")' onmouseout='tdout("+small_num+")'>만원</td>"
														+"<td id='td"+small_num+"_2'" + " onclick=tdclick("+20000+",'"+small_name+"','"+small_num+"')" + " onmouseover='tdover("+20000+","+small_num+")' onmouseout='tdout("+small_num+")'>2만원</td>"
														+"<td id='td"+small_num+"_3'" + " onclick=tdclick("+30000+",'"+small_name+"','"+small_num+"')" + " onmouseover='tdover("+30000+","+small_num+")' onmouseout='tdout("+small_num+")'>3만원</td>"
													+"</tr>"
													+"<tr style='cursor:pointer;'>"
														+"<td id='td"+small_num+"_4'" + " onclick=tdclick("+50000+",'"+small_name+"','"+small_num+"')" + " onmouseover='tdover("+50000+","+small_num+")' onmouseout='tdout("+small_num+")'>5만원</td>"
														+"<td id='td"+small_num+"_5'" + " onclick=tdclick("+100000+",'"+small_name+"','"+small_num+"')" + " onmouseover='tdover("+100000+","+small_num+")' onmouseout='tdout("+small_num+")'>10만원</td>"
														+"<td id='td"+small_num+"_6'" + " onclick=tdclick("+150000+",'"+small_name+"','"+small_num+"')" + " onmouseover='tdover("+150000+","+small_num+")' onmouseout='tdout("+small_num+")'>15만원</td>"
													+"</tr>"
													+"<tr  style='border-bottom:1px solid #4e4a41;cursor:pointer;'>"
														+"<td id='td"+small_num+"_7'" + " onclick=tdclick("+200000+",'"+small_name+"','"+small_num+"')" + " onmouseover='tdover("+200000+","+small_num+")' onmouseout='tdout("+small_num+")'>20만원</td>"
														+"<td id='td"+small_num+"_8'" + " onclick=tdclick("+300000+",'"+small_name+"','"+small_num+"')" + " onmouseover='tdover("+300000+","+small_num+")' onmouseout='tdout("+small_num+")'>30만원</td>"
														+"<td onclick=viewTextfield("+small_num+",'"+small_name+"')>직접입력</td>"
													+"</tr>"
												+"</table>"
											+"</div>";
									$(insertCode).appendTo("#smallList");
									
									tr +=1;
									var setTr ="<div style='clear:both;'></div>";
									if(tr%3 == 0){
										$(setTr).appendTo("#smallList");
									}
								}
							)
						}
					}
				);
			}		
		);
		
				
	}	
);
</script>
<style>
@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);
#big_num:hover{
   color:#8ba752;
   cursor:pointer;
   font-weight:bold;
}
table{
	font-weight:bold;
}
div{
	font-weight:bold;
}
div div label{
	font-weight:bold;
	font-size:15px;
}
#btnPatternResult{
	display: inline-block;
	padding: 6px 12px;
	margin-bottom: 0;
	font-size: 14px;
	font-weight: 400;
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
	color:#fff; 
	border: 1px solid transparent;
	border-radius: 4px;
	width:300px;
	border: 0;
	outline: 0;
}
</style>
</head>
<!-- <body style="background-color:#f5f4f0;">  -->
<body style="background-color:#f5f4f0; font-family: 'Noto Sans KR', sans-serif;"  >

<form action="/planCard/planResultView" method="post">
	
<input type="hidden" id="cardtypeflag" name="cardtypeflag" value="${cardtypeflag}" />
<input type="hidden" id="usemonthmoney" name="usemonthmoney" value="${usemonthmoney}" />
<div class="container" id="content">
	<div class="row">
		<div style="width:1200px; padding-top:20px; position:relative;">
		
			<!-- ST content -->
			<!-- ST 가맹점 분리 -->
			<div class="span2" style="border-top:2px solid #4e4a41">
				<c:forEach items="${bigDtoList}" var="bigClassDto" step="1" varStatus="i">
					<div style="padding-top:3px;">
						<span id ="big_num" value ="${bigClassDto.big_num}" style="display:inline-block; width:100%;">${bigClassDto.big_name}	</span>
					</div>
				</c:forEach>
			</div>
			<!-- END 가맹점 분리 -->
			
			<!-- ST pattern List -->


			<div class="span7" style="border-top:2px solid #4e4a41;border-bottom:2px solid #4e4a41; background-color:#ffffff;">
				<div id="smallTitle" >		
				</div>
				<div id="smallList">
					대분류를 선택해 주세요.
				</div>

			</div>
			<!-- END pattern List -->
			<div class="span4" style="border-top:2px solid #4e4a41;"><!-- position:fixed; top:140px;left:1025px;z-index:1; -->
				<label style="width:290px;height:30px; padding-top:10px;padding-left:10px;border-bottom:3px solid #4e4a41;font-size:18px;">
					소비내역
				</label>
				<table style="width:100%; ;border-bottom:1px solid #4e4a41;">
					<tr>
						<td style="padding-left:10px;width:170px;font-size:18px;">총 소비</td>
						<td id="useTotalMoney" style="padding-right:30px;width:70px; text-align:right" value="${usemonthmoney}">${usemonthmoney}</td>
					</tr>
				</table>
				<table style="width:100%;  border-bottom:1px solid #4e4a41;">
					<tr>
						<td style="padding-left:10px;width:170px;font-size:18px;">기타 소비</td>
						<td id="useEtcMoneyZero" style="padding-right:30px;width:60px;text-align:right;display:none;">0</td>
						<td id="useEtcMoney" style="padding-right:4px;width:60px;text-align:rightdisplay:block;">${usemonthmoney}</td>
					</tr>
				</table>
				<table style="margin-left:10px;">
					<tr><td id="usemoneyMessage">아직 입력한 소비패턴이 없습니다.</td></tr>
				</table>
				<table id="usemoney" style="margin-left:10px;cursor:pointer;">
				</table>
				<table id="resultSaveMoneyTable" style="width:100%; border-top:1px solid #4e4a41; display:none;">
					<tr>
						<td style="padding-left:10px;width:170px;font-size:13px;">예상 할인 금액</td>
						<td id="resultSaveMoney" style="padding-right:30px;width:70px; text-align:right"></td>
					</tr>
				</table>
				<!--<input type="button" value="추천카드 결과보기" class="btn" id="btnPatternResult" onclick="fnResult()"/>-->
				  <input type="submit" value="추천카드 결과보기" class="btn" id="btnPatternResult" />
				
			</div>
			<!-- END content -->
			
		</div>
	</div>
</div>
	
	
	


</form>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
</body>
</html>