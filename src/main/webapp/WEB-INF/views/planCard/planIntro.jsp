<!-- 
	카드추천 Intro Page 
		소비패턴을 통한, 회원의 관심사를 통한 카드추천 선택
	작성일 : 2016-07-18
	수정일 : 2016-07-18
	작성자 : 김상덕
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page session="true" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- Bootstrap 3.3.4 -->
<link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet"
	type="text/css" />
<!-- Font Awesome Icons -->
<link
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css"
	rel="stylesheet" type="text/css" />
<!-- Ionicons -->
<link
	href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css"
	rel="stylesheet" type="text/css" />
<!-- Theme style -->
<link href="/resources/dist/css/AdminLTE.min.css" rel="stylesheet"
	type="text/css" />
<!-- AdminLTE Skins. Choose a skin from the css/skins 
         folder instead of downloading all of them to reduce the load. -->
<link href="/resources/dist/css/skins/_all-skins.min.css"
	rel="stylesheet" type="text/css" />
	
	
	
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

<form action="" method="post">

<div class="container">
	<div class="row">
		<div class="span6">
							
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
					<div class="inner" id="selected">
					</div>
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
						<input type="submit" class="btn btn-info btn-block" value="소비패턴등록" />
					</div>
					<div class="span2">
						<input type="button" class="btn btn-info btn-block" value="관심분야로 찾기" /><br/>
					</div>
				</div>
				
			</div>	
		</div>
	</div>
</div>

</form>

</body>
</html>
