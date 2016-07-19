<!-- 
	카드추천 Intro Page 
		1. 소비패턴 추천
			신용,체크 / 월사용금액
		2. 관심사로 추천
			회원의 관심사
	작성일 : 2016-07-18
	수정일 : 2016-07-18
	작성자 : 김상덕
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
	[class*="col-"]{
  		padding: 8px;
 	 	border: 1px solid skyblue;
  		align: center;
  		margin:10px;
	}
	.warp{position:relative}
	.inner{position:absolute; bottom:1px;left:1px;}
	
</style>

</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<form action="/planCard/planPattern.plan" method="post">


<div class="container" id="content">
	<div class="row">
		<div class="span12">

			<!-- ST content  -->
			<div class="span5 offset2 col-">
				<div class="span5">
					<h3 class="text-left text-info">카드종류</h3>
					<select name="card_classify" class="form-control">
						<option value="신용">신용 카드</option>
						<option value="체크">체크 카드</option>
					</select>
				</div>

				<div class="warp span5">
					<h3 class="text-left text-info">월 카드 총 소비액</h3>
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
						<input type="submit" class="btn btn-info btn-block"
							value="소비패턴등록" />
					</div>
					<div class="span2">
						<input type="button" class="btn btn-info btn-block"
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
