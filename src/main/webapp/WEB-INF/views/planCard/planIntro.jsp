<!-- 
	카드추천 Intro Page 
		1. 소비패턴 추천
			신용,체크 / 월사용금액
		2. 관심사로 추천
			회원의 관심사
	작성일 : 2016-07-18
	수정일 : 2016-08-03
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
<title>plan Intro</title>
<style>
	@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);
	[class*="col-"]{
  		padding: 8px;
 	 	border: 1px solid #4e4a41;
  		align: center;
  		margin:10px;
	}
	.warp{position:relative}
	.inner{position:absolute; bottom:1px;left:1px;}
	
	#patternBtn, #categoryBtn{
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
<body style="background-color:#f5f4f0; font-family: 'Noto Sans KR', sans-serif;"  >

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<form action="/planCard/planPattern.plan" method="post">


<div class="container" id="content">
	<div class="row">
		<div class="span12">

			<!-- ST content  -->
			<div class="span5 offset2 col-">
				<div class="span5">
					<h3 class="text-left text-info" style="color:#5c554b;">카드종류</h3>
					<select name="card_classify" class="form-control">
						<option value="신용">신용 카드</option>
						<option value="체크">체크 카드</option>
					</select>
				</div>

				<div class="warp span5">
					<h3 class="text-left text-info" style="color:#5c554b;">월 카드 총 소비액</h3>
					<div class="inner" id="selected"></div>
					<select name="cuns" id="cuns" class="form-control">
						<option value="300000">30만원</option>
						<option value="500000">50만원</option>
						<option value="700000">70만원</option>
						<option value="1000000">100만원</option>
						<option value="1500000">150만원</option>
						<option>직접입력</option>
					</select>
				</div>

				<div class="span5">
					<div class="span2">
						<input type="submit" id="patternBtn" class="btn btn-info btn-block"
							value="소비패턴등록" />
					</div>
					<div class="span2">
						<input type="button" id="categoryBtn" class="btn btn-info btn-block"
							value="관심분야로 찾기" /><br />
					</div>
				</div>
			</div>
			<!-- END content -->
			
		</div>
	</div>
</div>





</form>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
</body>
</html>
