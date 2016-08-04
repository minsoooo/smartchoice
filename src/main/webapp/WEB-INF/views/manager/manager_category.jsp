<!-- 
	관리자 카테고리 관리 페이지
	작성일 : 2016-08-02
	수정일 : 2016-08-03
	작성자 : 김상덕
	ManagerCategory Snapshot 1.0 by.santori
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page session="true" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/common/mng_header.jsp"></jsp:include>
<title>admin_category</title>
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css" />
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script>
function InUpSubmit(){
	var controlFlag = 0;
	if($("#btnInUp").val()=="추가"){
		if($("#CateLabel").text().substring(0,1)=="["){//소분류 일 경우
			//1 소분류 추가 (대분류 넘 필요)
			controlFlag = 1;
		}else{//대분류 일 경우
			//2 대분류 추가 (그냥 추가)
			controlFlag = 2;
		}
	}else if($("#btnInUp").val()=="수정"){
		if($("#CateLabel").text().substring(0,1)=="["){//소분류 일 경우
			//3 소분류 수정 (소분류 넘)
			controlFlag = 3;
		}else{//대분류 일 경우
			//4 대분류 수정 (대분류 넘)
			controlFlag = 4;
		}
	}
	$("#controlFlag").val(controlFlag);
	if (confirm($("#btnInUp").val()+"하시겠습니까?") == true){
		$('form').submit();
	}else{	// 취소
		return false;
	}
}

function selectMode(mode){
	if($("#nonSmall").val()==1 && mode!=0){
		alert("선택된 소분류가 없습니다.");
		return false;
	}
	$("#CateInUpDiv").css("display","block");
	var InUp = null;
	var BigSmallMode = null;
	var SmallName = null;
	var SmallNum = null;
	var BigName = null;
	var BigNum = null;
	if(mode==0){
		InUp="추가";
		$("#btnInUp").val(InUp);
	}else{
		InUp="수정";
		$("#btnInUp").val(InUp);
		SmallName = $("#SmallName").val();
		SmallNum = $("#SmallNum").val();
		BigName = $("#BigName").val();
		BigNum = $("#BigNum").val();
	}
	if($("#BigSmallMode").val()==0){
		BigSmallMode="대분류";
		$("#CateInUpText").val(BigName);
	}else{
		BigSmallMode= "["+$("#bigCateLabel").text()+"] "+"소분류";
		$("#CateInUpText").val(SmallName);
	}
	$("#InUpCateLabel").text(InUp);
	$("#CateLabel").text(BigSmallMode);
}

function smallCateClick(small_num, small_name, big_name, bignum){
	var divSmall = "#divSmall"+small_num;
	$(".small_num").css("background-color", "").css("color", "");
	$(divSmall).css("background-color", "#8ba752").css("color", "#fff");
	$("#bigCateLabel").text(big_name);
	$("#smallCatewriteDiv").css("display", "block");
	$("#smallCateLabel").text(small_name);
	$("#BigSmallMode").val(1);
	$("#SmallName").val(small_name);
	$("#SmallNum").val(small_num);
	$("#CateInUpText").val("");
}
function nonSmallCate(){//스몰 카테고리가 하나도 없는경우
	$("#nonSmall").val(1);
	var message = "소분류를 등록 하려면 클릭"
	var big_name = $("#BigName").val();
	var big_num = $("#BigNum").val();
	var small_num = "";
	var small_name = "";
	var insertSmallCateCode ="<div id='divSmall"+small_num+"'"+" class='small_num'"
	+" onclick=smallCateClick('"+small_num+"','"+small_name+"','"+big_name+"','"+big_num+"')"
	+" style='padding-left:10px;padding-top:5px;'>" +message+ "</div>";
	$(insertSmallCateCode).appendTo("#smallcateDiv");
}

//////////////////////////////////////////////////////////////////imgTEST
//카드 이미지 미리보기
/*
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
			reader.readAsDataURL(inputFile.files[0]);
		} catch (e) { }
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
		} else {}
	};
	// onchange
	$(this).change(function() {
		previewImage();
	});
};
*/
//////////////////////////////////////////////////////////////////imgTEST

$(document).ready(
	function(){
		///////////////////////////////////////////////////////////////////imgTEST
		/*
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
		*/
		///////////////////////////////////////////////////////////////////imgTEST
			
		$("span").click(
			function(){
				$("span").css("background-color", "").css("color", "");
				$(this).css("background-color", "#8ba752").css("color", "#fff");
				
				$("#smallcateDiv").empty();
				var blgclass_num = $(this).attr("value");
				
				$("#BigName").val($(this).text());
				$("#BigNum").val(blgclass_num);
				$("#BigSmallMode").val(0);
				$("#bigCateLabel").text($(this).text());
				$("#bigCateLabel").text($(this).text());
								
				$.get("/planCard/getSmallclass",{"blgclass_num":blgclass_num}).done(
					function(xmlData){
						var category = $(xmlData).find("category");
						
						if(category.length){
							$(category).each(
								function(){
									$("#nonSmall").val(0);
									var small_num = $(this).find("small_num").text();
									var small_name = $(this).find("small_name").text();
									var big_name = $(this).find("big_name").text();
									var big_num = $(this).find("big_num").text();
									var category_img = "/resources/images/category/"+ $(this).find("small_img").text().trim();
									
									$("#CateInUpText").val("");
									$("#BigName").val(big_name);
									$("#BigNum").val(big_num);
									$("#BigSmallMode").val(0);
									$("#bigCateLabel").text("");
									$("#bigCateLabel").text(big_name);
									$("#smallCatewriteDiv").css("display", "none");
									var insertSmallCateCode ="<div id='divSmall"+small_num+"'"+" class='small_num'"
										+" onclick=smallCateClick('"+small_num+"','"+small_name+"','"+big_name+"','"+big_num+"')"
										+" style='padding-left:10px;padding-top:5px;'>" +small_name+ "</div>";
									$(insertSmallCateCode).appendTo("#smallcateDiv");
								}
							)
						}else{
							nonSmallCate();
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
label{
	font-weight:bold;
	font-size:14px;
}
#big_num{
	display : inline-block;
	width:100%;
}
.small_num:hover{
   color:#8ba752;
   cursor:pointer;
   font-weight:bold;
}
#bigcateDiv, #smallcateDiv{
	border-top:2px solid #4e4a41;
	font-weight:bold;
	font-size:14px;
}
#catewriteDiv{
	border-top:2px solid #4e4a41;
	font-weight:bold;
	font-size:16px;
}
#bigcateDiv div{
	padding-left:10px;
	padding-top:5px;
}
#catewriteDiv div{
	padding-left:20px;
	padding-top:5px;
}
#bigCatewriteDiv{
	margin-top:5px;
}

#smallCatewriteDiv{
	display:none;
}
#titleFont{
	color :#97b162;
	font-size: 25px;
	font-weight:bold;
}
#CateLabel, #InUpCateLabel{
	font-size: 14px;
	color:#4e4a41;
}

#btnInsert, #btnUpdate, #btnInUp{
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
	width:120px;
	border: 0;
	outline: 0;
}

</style>
</head>
<body style ="background-color: #f5f4f0">
<form method="post" action="/manager/manager_categoryControl" id="formInUp" enctype="multipart/form-data">
	<input type="hidden" name="nonSmall" id="nonSmall" value=""/>
	<input type="hidden" name="BigSmallMode" id="BigSmallMode" value=""/>
	<input type="hidden" name="SmallName" id="SmallName" value=""/>
	<input type="hidden" name="SmallNum" id="SmallNum" value=""/>
	<input type="hidden" name="BigName" id="BigName" value=""/>
	<input type="hidden" name="BigNum" id="BigNum" value=""/>
	<input type="hidden" name="controlFlag" id="controlFlag" value=""/>
	<div class="container">
		<div class="row">
			<div class="span12" id ="titleDiv" style="padding-top:20px;">
				<ul>
					<li>
						<font id ="titleFont">분류관리</font>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="span12" >
				<div class="span3" id="bigcateDiv">
					<c:forEach items="${bigDtoList}" var="bigClassDto" step="1" varStatus="i">
						<div>
							<span id="big_num" value="${bigClassDto.big_num}">${bigClassDto.big_name}</span>
						</div>
					</c:forEach>
				</div>
				
				<div class="span3" id="smallcateDiv">
				</div>
				
				<div class="span4" id="catewriteDiv">
					<div style="height:80px;">
						<div id="bigCatewriteDiv">
							<label style="float:left; padding-left:10px;">대분류 :</label>
							<label id="bigCateLabel" style="float:left; padding-left:20px;"></label>
							<div style="clear:both;"></div>
						</div>
						<div id="smallCatewriteDiv" >
							<label style="float:left; padding-left:10px;">소분류 :</label>
							<label id="smallCateLabel" style="float:left; padding-left:20px;"></label>
							<div style="clear:both;"></div>
						</div>
					</div>
			 		<div style="text-align:center;border-bottom:2px solid #4e4a41; padding-bottom:20px;">
			 			<input type="button" value="추 가" class="btn" id="btnInsert" onclick="selectMode(0)" />
						<input type="button" value="수 정" class="btn" id="btnUpdate" onclick="selectMode(1)" /> 
					</div>
					
					<div id="CateInUpDiv" style="display:none; padding-top:30px; border-bottom:2px solid #4e4a41;">
						<div style="float:left;width:2px;background-color:#4e4a41;"></div>
						 <label id="CateLabel" style="float:left; margin-left:5px; "></label>
						 <label id="InUpCateLabel" style="float:left; padding-left:10px;"></label>
						 <div style="clear:both;"></div>
						 <input type="text" id="CateInUpText" name="CateInUpText" value="" style="margin-left:20px;"/>
						 <input type="button" value="추가수정" class="btn" id="btnInUp" onclick="InUpSubmit()" style="width:220px; margin-left:20px;" /> 
						 <div style="height:20px;"></div>
					</div>
					<!-- 
					<table style="margin-left: 30px;">
						<tr>
							<td id="imgSpace">
								<img id="imgPre" src="/resources/images/category/bus.png" />
							</td>
						</tr>
						<tr>
							<td>
								<div class="filebox">
									<label for="input_file">카드이미지 등록</label> 
									<input class="btn-style" type="file" id="input_file" name="input_file">
								</div>
							</td>
						</tr>
					</table>
					 -->
				</div>
				
			</div>
		</div>
	</div>
</form>	
</body>
</html>